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

  static Future<List<ImageInfoModel>> _getImageInfo(
      {DateTime? randomImagesLastViewedCheckpoint, int? limit}) async {
    Db db = await _getDB();
    DbCollection imageInfo =
        db.collection(ImageDatabaseCollections.imageinfos.name);
    SelectorBuilder selectorBuilder = where.sortBy('updatedAt');
    if (randomImagesLastViewedCheckpoint != null) {
      selectorBuilder.gt('updatedAt', randomImagesLastViewedCheckpoint);
    }
    if (limit != null) {
      selectorBuilder.limit(limit);
    }
    return (await imageInfo.find(selectorBuilder).toList())
        .map((data) => ImageInfoModel.fromMap(data))
        .toList();
  }

  static Future<List<ImageInfoModel>> randomImages(
      {required int perPage}) async {
    UserModel currentUser = await UserDatabase.getCurrentUser();
    List<ImageInfoModel> images = await _getImageInfo(
        randomImagesLastViewedCheckpoint:
            currentUser.randomImagesLastViewedCheckpoint,
        limit: perPage);

    print(images);

    if (images.length < perPage) {
      images = await _getImageInfo(limit: perPage - images.length);
    }
    return images;
  }
}

enum ImageDatabaseCollections { imageinfos }
