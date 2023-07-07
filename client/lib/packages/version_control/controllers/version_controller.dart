part of version_control;

class VersionController {
  static const String _collectionPath = "app";
  static const String _docPath = "version";

  static Future<bool> isUpdateAvailable() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(_collectionPath);
    DocumentSnapshot versionRef = await collectionRef.doc(_docPath).get();
    if (!versionRef.exists) return false;

    String? cloudVersion = versionRef.get(VersionUtils.platformName());

    if (cloudVersion == null) return false;
    String currentVersion = (await PackageInfo.fromPlatform()).version;
    int isOutdated = VersionUtils.compareVersion(cloudVersion, currentVersion);

    return isOutdated == 1;
  }
}
