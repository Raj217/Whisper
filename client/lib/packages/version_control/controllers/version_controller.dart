part of version_control;

class VersionController {
  static VersionController? _instance;
  VersionController._();

  factory VersionController() {
    _instance ??= VersionController._();
    return _instance!;
  }

  static const String _appReleaseBasePath = "app_release";
  static DownloadTask? _downloadTask;

  static DownloadTask? get downloadTask => _downloadTask;
  static void resetDownloadTask() => _downloadTask = null;

  static Future<bool> isAppDownloaded() async {
    return await File(await VersionUtils.getAppUpdateLocalStoragePath())
        .exists();
  }

  static Future<bool> isUpdateAvailable() async {
    String? cloudVersion = await VersionUtils.getLatestVersion();

    if (cloudVersion == null) return false;
    String currentVersion = (await PackageInfo.fromPlatform()).version;
    int isOutdated = VersionUtils.compareVersion(cloudVersion, currentVersion);

    return isOutdated == 1;
  }

  static Future<DownloadTask?> downloadAndInstallUpdate() async {
    if (_downloadTask != null) return _downloadTask;

    PermissionStatus status = await Permission.requestInstallPackages.request();
    if (status != PermissionStatus.denied ||
        status != PermissionStatus.permanentlyDenied) {
      String appName = await VersionUtils.getAppName();
      String filePath = await VersionUtils.getAppUpdateLocalStoragePath();

      final file = File(filePath);
      if (file.existsSync()) {
        await OpenFile.open(filePath);
      } else {
        File incompleteFile =
            File(await VersionUtils.getTempDownloadFileName());
        if (await incompleteFile.exists()) {
          await incompleteFile.delete();
        }
        _downloadTask = FirebaseStorage.instance
            .ref('$_appReleaseBasePath/$appName')
            .writeToFile(File(await VersionUtils.getTempDownloadFileName()));
      }
    }
    _downloadTask?.snapshotEvents.listen((snapshot) async {
      if (snapshot.bytesTransferred == snapshot.totalBytes) {
        File file = File(await VersionUtils.getTempDownloadFileName());
        String fileName = await VersionUtils.getAppUpdateLocalStoragePath();
        await file.rename(fileName);
        await OpenFile.open(fileName);
      }
    });
    return _downloadTask;
  }
}
