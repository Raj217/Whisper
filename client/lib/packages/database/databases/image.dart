part of network_engine;

class Database {
  Future<Db> _getDB() async {
    if (dotenv.env[EnvValues.MONGO_URI.name] == null) {
      throw Exception("Database URL not found");
    }

    Db db = Db(dotenv.env[EnvValues.MONGO_URI.name]!);
    await db.open();
    return db;
  }

  Future randomImages({int perPage = 10}) async {
    Db db = await _getDB();
    DbCollection imageInfo = db.collection('ImageInfo');
    await imageInfo.find()
  }
}

enum EnvValues { MONGO_URI }
