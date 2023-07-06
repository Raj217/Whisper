import 'package:flutter/material.dart';
import 'widgets/item_animated_bg.dart';
import 'widgets/item_content.dart';
import 'package:whisper/widgets/buttons/buttons.dart';
import 'package:whisper/packages/rive/rive.dart';

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
          ItemContent(riveWidget: riveWidget, text: text)
        ],
      ),
    );
  }
}
