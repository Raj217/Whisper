import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
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
              Item(
                riveWidget: HomeIcon(height: 30),
                text: "Home",
                isSelected: selectedIcon == 0,
                onTap: () {
                  setState(() {
                    selectedIcon = 0;
                  });
                },
              ),
              Item(
                riveWidget: SettingsIcon(height: 30),
                text: "Settings",
                isSelected: selectedIcon == 1,
                onTap: () {
                  setState(() {
                    selectedIcon = 1;
                  });
                },
              ),
              Item(
                text: "Log Out",
                isSelected: selectedIcon == 2,
                onTap: () {
                  setState(() {
                    selectedIcon = 2;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
