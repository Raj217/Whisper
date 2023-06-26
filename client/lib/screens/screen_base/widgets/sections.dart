import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';
import 'item.dart';

class Section extends StatelessWidget {
  final List<Item> items;
  final bool addBottomDivider;
  final double gap;
  const Section({
    super.key,
    required this.items,
    this.gap = 30,
    this.addBottomDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...items.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: gap),
            child: item,
          ),
        ),
        if (addBottomDivider)
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: const Divider(
                  color: whiteSwatch,
                ),
              ),
            ),
          )
      ],
    );
  }
}
