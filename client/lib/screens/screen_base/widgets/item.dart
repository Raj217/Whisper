import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
import 'package:whisper/widgets/rive/rive.dart';

class Item extends StatelessWidget {
  final Widget? riveWidget;
  final String text;
  final void Function() onTap;
  final bool isSelected;
  const Item({
    super.key,
    this.riveWidget,
    required this.onTap,
    required this.text,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          AnimatedContainer(
            height: 50,
            curve: Curves.fastOutSlowIn,
            duration: kThemeAnimationDuration,
            alignment: Alignment.centerLeft,
            width: isSelected ? MediaQuery.of(context).size.width * 0.43 : 0,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              gradient: LinearGradient(
                colors: [lightBlueSwatch.shade100, lightBlueSwatch.shade900],
              ),
            ),
          ),
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
