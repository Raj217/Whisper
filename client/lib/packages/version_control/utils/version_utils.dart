part of version_control;

class VersionUtils {
  static const String _collectionPath = "app";
  static const String _docPath = "version";
  VersionUtils._();

  static Future<String> getTempDownloadFileName() async {
    return '${await VersionUtils.getAppUpdateLocalStoragePath()}.download';
  }

  static Future<String> getAppUpdateLocalStoragePath() async {
    Directory? tempDir = await getTemporaryDirectory();
    return '${tempDir.path}/${await getAppName()}';
  }

  static Future<String> getAppName() async {
    return '${platformName()}_v${await getLatestVersion()}.${fileExtension()}';
  }

  static Future<String?> getLatestVersion() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(_collectionPath);
    DocumentSnapshot versionRef = await collectionRef.doc(_docPath).get();
    if (!versionRef.exists) return "";

    return versionRef.get(platformName());
  }

  static String fileExtension() {
    if (Platform.isAndroid) {
      return "apk";
    } else {
      throw UnimplementedError("Sorry current platform is not planned yet");
    }
  }

  static String platformName() {
    // to avoid future possible bug of different name
    // switch statement is introduced
    if (Platform.isAndroid) {
      return "android";
    } else {
      throw UnimplementedError("Sorry current platform is not planned yet");
    }
  }

  static (int, int) _next(String version, int i) {
    int ver = 0;
    for (; i < version.length && version[i] != '.'; i++) {
      ver = ver * 10 + version.codeUnitAt(i);
    }
    i++;
    return (ver, i);
  }

  static int compareVersion(String version1, String version2) {
    int i1 = 0, i2 = 0;
    int v1, v2;
    while (i1 < version1.length || i2 < version2.length) {
      (v1, i1) = _next(version1, i1);
      (v2, i2) = _next(version2, i2);
      if (v1 < v2) return -1;
      if (v1 > v2) return 1;
    }
    return 0;
  }
}
