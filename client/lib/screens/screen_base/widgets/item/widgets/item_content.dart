import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/packages/rive/rive.dart';

class ItemContent extends StatelessWidget {
  final RiveWidgetBase? riveWidget;
  final String text;
  const ItemContent({
    super.key,
    required this.riveWidget,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
