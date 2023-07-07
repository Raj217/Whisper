import 'dart:math';
import 'package:flutter/material.dart';
import 'package:whisper/configs/theme/theme.dart';

class ItemAnimatedBG extends StatelessWidget {
  final bool isSelected;
  const ItemAnimatedBG({
    super.key,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 50,
      curve: Curves.fastOutSlowIn,
      duration: kThemeAnimationDuration,
      alignment: Alignment.centerLeft,
      width: isSelected ? min(MediaQuery.of(context).size.width * 0.4, 200) : 0,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        gradient: LinearGradient(
          colors: [accentSwatch.shade100, accentSwatch.shade900],
        ),
      ),
    );
  }
}
