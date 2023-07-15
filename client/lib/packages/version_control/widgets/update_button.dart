part of version_control;

class UpdateButton extends StatefulWidget {
  const UpdateButton({super.key});

  @override
  State<UpdateButton> createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> {
  double loadingIconSize = 15;
  DownloadTask? downloadUpdate;
  String message = "Up to date";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<bool>>(
      future: Future.wait([
        VersionController.isUpdateAvailable(),
        VersionController.isAppDownloaded()
      ]),
      builder: (BuildContext context,
          AsyncSnapshot<List<bool>> updateCheckSnapshot) {
        if (updateCheckSnapshot.connectionState == ConnectionState.waiting) {
          message = "Checking for update";
        } else {
          message = "Up to date";
        }
        if (updateCheckSnapshot.hasData &&
            updateCheckSnapshot.data?[0] == true) {
          message = "Update";
        }

        return StreamBuilder(
            stream: downloadUpdate?.snapshotEvents,
            builder: (BuildContext context,
                AsyncSnapshot<TaskSnapshot?> downloadSnapshot) {
              bool isDownloading = false;
              double progress = 0;
              if (downloadSnapshot.hasData && downloadSnapshot.data != null) {
                isDownloading = true;
                progress = downloadSnapshot.data!.bytesTransferred /
                    downloadSnapshot.data!.totalBytes;
                message = "${(progress * 100).toStringAsFixed(2)} %";
              }
              if (progress == 1 || updateCheckSnapshot.data?[1] == true) {
                message = "Install";
                VersionController.resetDownloadTask();
                isDownloading = false;
              }
              return ElevatedButton(
                onPressed: updateCheckSnapshot.data?[0] == true
                    ? () {
                        setState(() {
                          isDownloading = true;
                        });
                        VersionController.downloadAndInstallUpdate()
                            .then((task) => setState(() {
                                  downloadUpdate = task;
                                }));
                      }
                    : null,
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: kThemeAnimationDuration,
                      height: isDownloading ? loadingIconSize : 0,
                      width: isDownloading ? loadingIconSize : 0,
                      margin: EdgeInsets.only(right: isDownloading ? 10 : 0),
                      child: CircularProgressIndicator(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        value: progress,
                        strokeWidth: 2,
                      ),
                    ),
                    Text(
                      message,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
