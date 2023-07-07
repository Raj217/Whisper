import 'package:flutter/material.dart';
import 'package:whisper/packages/version_control/version_control.dart';
import 'widgets/app_Info_item.dart';
import 'package:whisper/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:whisper/widgets/widgets_organiser/section.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatefulWidget {
  static const String routeName = "/settingsScreen/AboutScreen";
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo? packageInfo;
  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      setState(() {
        packageInfo = info;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(
        pageName: "About",
        automaticallyImplyLeading: true,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView(
          children: [
            Section(
              title: "About App",
              children: [
                AppInfoItem(title: "Name", data: packageInfo?.appName),
                AppInfoItem(title: "Version", data: packageInfo?.version),
                AppInfoItem(
                    title: "Build Number", data: packageInfo?.buildNumber),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                UpdateButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
