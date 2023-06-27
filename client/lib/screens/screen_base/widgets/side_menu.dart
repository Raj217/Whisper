import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/screens/auth_screen/auth_screen.dart';
import 'package:whisper/states/auth/auth.dart';
import 'sections.dart';
import 'item.dart';
import 'package:whisper/widgets/rive/rive.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int selectedIcon = 0;
  List<RiveBase?> controllers = List.filled(3, null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueSwatch,
      body: ListView(
        children: [
          const SizedBox(height: 90),
          Section(
            addBottomDivider: false,
            items: [
              // TODO: Change the items to a list
              Item(
                riveWidget: HomeIcon(
                    height: 30,
                    onInit: (RiveBase controller) {
                      controllers[0] = controller;
                      if (selectedIcon == 0) {
                        controller.changeState();
                      }
                    }),
                text: "Home",
                isSelected: selectedIcon == 0,
                onTap: () {
                  controllers[0]?.changeState();
                  setState(() {
                    selectedIcon = 0;
                  });
                },
              ),
              Item(
                riveWidget: SettingsIcon(
                    height: 30,
                    onInit: (RiveBase controller) {
                      controllers[1] = controller;
                      if (selectedIcon == 1) {
                        controller.changeState();
                      }
                    }),
                text: "Settings",
                isSelected: selectedIcon == 1,
                onTap: () {
                  controllers[1]?.changeState();
                  setState(() {
                    selectedIcon = 1;
                  });
                },
              ),
              Item(
                text: "Log Out",
                isSelected: selectedIcon == 2,
                onTap: () async {
                  setState(() {
                    selectedIcon = 2;
                  });
                  await Future.delayed(const Duration(milliseconds: 300));
                  await Authenticator.logOut();
                  if (mounted) {
                    Navigator.pushNamed(context, AuthScreen.routeName);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
