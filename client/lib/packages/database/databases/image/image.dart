part of database;

class ImageDatabase {
  static Db? _db;

  static Future<Db> _getDB() async {
    if (ImageDatabase._db != null) return ImageDatabase._db!;
    if (dotenv.env[EnvValues.MONGO_URI.name] == null) {
      throw Exception(
          releaseMessage: "Couldn't connect to database",
          debugMessage: "Database URL not found");
    }

    ImageDatabase._db = await Db.create(dotenv.env[EnvValues.MONGO_URI.name]!);
    await ImageDatabase._db!.open();
    return ImageDatabase._db!;
  }

  static List<ImageInfoModel> _convertListToImageInfo(
      List<Map<String, dynamic>> data) {
    return data.map((data) => ImageInfoModel.fromMap(data)).toList();
  }

  static Future<List<ImageInfoModel>> _getImages(
      {DateTime? randomImagesLastViewedCheckpoint, required int limit}) async {
    Db db = await _getDB();
    DbCollection imageInfo =
        db.collection(ImageDatabaseCollections.imageinfos.name);
    SelectorBuilder selectorBuilder = where.sortBy('updatedAt');
    if (randomImagesLastViewedCheckpoint != null) {
      selectorBuilder.gt('updatedAt', randomImagesLastViewedCheckpoint);
    }
    selectorBuilder.limit(limit);
    return _convertListToImageInfo(
      await imageInfo.find(selectorBuilder).toList(),
    );
  }

  static Future<List<ImageInfoModel>> publisherImages(
      {required int page,
      required int perPage,
      required String publisherName,
      required ImageSource source}) async {
    Db db = await _getDB();
    DbCollection imageInfo =
        db.collection(ImageDatabaseCollections.imageinfos.name);
    SelectorBuilder selectorBuilder = where
        .sortBy('updatedAt', descending: true)
        .eq('publisherName', publisherName)
        .eq('source', source.name)
        .skip(page * perPage)
        .limit(perPage);

    return _convertListToImageInfo(
      await imageInfo.find(selectorBuilder).toList(),
    );
  }

  static Future<List<ImageInfoModel>> randomImages(
      {required int perPage}) async {
    UserModel currentUser = await UserDatabase.getCurrentUser();
    List<ImageInfoModel> images = await _getImages(
        randomImagesLastViewedCheckpoint:
            currentUser.randomImagesLastViewedCheckpoint,
        limit: perPage);

    if (images.length < perPage) {
      images = await _getImages(limit: perPage - images.length);
    }
    return images;
  }
}

enum ImageDatabaseCollections { imageinfos }
