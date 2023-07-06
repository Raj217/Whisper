import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const Item({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Icon(
            Icons.chevron_right,
            size: 14,
          )
        ],
      ),
    );
  }
}
