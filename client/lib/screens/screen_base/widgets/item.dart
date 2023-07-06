import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/screens/screen_base/widgets/item_animated_bg.dart';
import 'dart:math';
import 'package:whisper/widgets/buttons/buttons.dart';
import 'package:whisper/widgets/rive/rive.dart';

class Item extends StatelessWidget {
  final String text;
  final double height;
  final bool isSelected;
  final void Function() onTap;
  final RiveWidgetBase? riveWidget;
  const Item({
    super.key,
    this.riveWidget,
    this.height = 30,
    required this.text,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return HoveredGestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ItemAnimatedBG(isSelected: isSelected),
          Row(
            children: [
              const SizedBox(width: 10),
              SizedBox(width: 30, child: riveWidget),
              const SizedBox(width: 10),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: whiteSwatch),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
