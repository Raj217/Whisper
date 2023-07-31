part of database;

class URLGenerator {
  Map<String, String> queries = {};
  ImageInfoModel imageInfo;

  URLGenerator({required this.imageInfo});

  void addQuery(String key, String value) {
    queries[key] = value;
  }

  String get _baseURL {
    String? baseURL;
    if (imageInfo.source == ImageSource.unsplash) {
      baseURL =
          "${dotenv.env[EnvValues.UNSPLASH_IMAGE_API_BASE_URL.name]}/photo-${imageInfo.imageSourceID}";
    } else if (imageInfo.source == ImageSource.pexels) {
      baseURL =
          "${dotenv.env[EnvValues.PEXELS_IMAGE_API_BASE_URL.name]}/photos/${imageInfo.imageSourceID}/${imageInfo.fileName}";
    }
    if (baseURL == null) {
      throw Exception(
        debugMessage:
            "Could not find base URL for the given source: ${imageInfo.source}",
        releaseMessage: "Could not generate Image URL",
      );
    }
    return baseURL;
  }

  String get url {
    String queryString = "";
    for (MapEntry<String, String> query in queries.entries) {
      queryString += "&${query.key}=${query.value}";
    }
    if (queryString.isNotEmpty) {
      queryString = '?${queryString.substring(1)}';
    }
    return _baseURL + queryString;
  }
}
