part of database;

class ImageDatabase {
  static Future<Db> _getDB() async {
    if (dotenv.env[EnvValues.MONGO_URI.name] == null) {
      throw Exception(
          releaseMessage: "Couldn't connect to database",
          debugMessage: "Database URL not found");
    }

    Db db = await Db.create(dotenv.env[EnvValues.MONGO_URI.name]!);
    await db.open();
    return db;
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

  static Future<List<ImageInfoModel>> randomImages({int perPage = 10}) async {
    UserModel currentUser = await UserDatabase.getCurrentUser();

    print(currentUser);
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
