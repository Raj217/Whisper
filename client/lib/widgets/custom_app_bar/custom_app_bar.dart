import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/states/screen/screen.dart';

class CustomAppBar {
  CustomAppBar._();

  static const double _leftPad = 65;
  static const double _rightActionPad = 10;
  static const double _automaticallyImplyLeadingSize = 25;

  static AppBar appBar({
    required BuildContext context,
    String? pageName,
    List<Widget> children = const [],
    List<Widget> actions = const [],
    bool automaticallyImplyLeading = false,
  }) {
    if (actions.isNotEmpty) {
      actions.add(const SizedBox(width: _rightActionPad));
    }
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leadingWidth: 70,
      leading: automaticallyImplyLeading
          ? Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: const EdgeInsets.all(15),
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: _automaticallyImplyLeadingSize,
                ),
              ),
            )
          : null,
      title: StatefulBuilder(
        builder: (BuildContext context, _) {
          return Consumer(
            builder: (BuildContext context, WidgetRef ref, _) {
              ScreenModel screenModel = ref.watch(screenProvider);
              return Row(
                children: [
                  if (automaticallyImplyLeading == false)
                    AnimatedContainer(
                      duration: kThemeAnimationDuration,
                      width: screenModel.isMenuOpen ? 0 : _leftPad,
                    ),
                  if (pageName != null)
                    Text(
                      pageName,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ...children,
                ],
              );
            },
          );
        },
      ),
      actions: actions,
    );
  }
}
