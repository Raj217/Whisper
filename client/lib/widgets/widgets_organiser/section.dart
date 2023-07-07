import 'package:flutter/material.dart';
import 'dart:math';

class Section extends StatelessWidget {
  final bool addBottomDivider;
  final List<Widget> children;
  final String title;
  final double gap;
  final double childLeftPad;
  const Section({
    super.key,
    this.addBottomDivider = true,
    required this.children,
    required this.title,
    this.gap = 10,
    this.childLeftPad = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).disabledColor,
              ),
        ),
        ...children.map(
          (child) => Padding(
            padding: EdgeInsets.only(top: gap, left: childLeftPad),
            child: child,
          ),
        ),
        if (addBottomDivider)
          Padding(
            padding: EdgeInsets.only(top: gap),
            child: Center(
              child: SizedBox(
                width: min(MediaQuery.sizeOf(context).width * 0.7, 250),
                child: Divider(
                  color: Theme.of(context).disabledColor,
                  thickness: 1.3,
                ),
              ),
            ),
          )
      ],
    );
  }
}
