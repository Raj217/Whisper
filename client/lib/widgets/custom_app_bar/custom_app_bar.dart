import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/states/screen/screen.dart';

class CustomAppBar {
  CustomAppBar._();

  static const double _leftPad = 65;

  static AppBar appBar({required List<Widget> children}) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: StatefulBuilder(
        builder: (BuildContext context, _) {
          return Consumer(
            builder: (BuildContext context, WidgetRef ref, _) {
              ScreenModel screenModel = ref.watch(screenProvider);
              return Row(
                children: [
                  AnimatedContainer(
                    duration: kThemeAnimationDuration,
                    width: screenModel.isMenuOpen ? 0 : _leftPad,
                  ),
                  ...children,
                ],
              );
            },
          );
        },
      ),
    );
  }
}
