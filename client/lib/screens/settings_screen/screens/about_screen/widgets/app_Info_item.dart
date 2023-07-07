import 'package:flutter/material.dart';

class AppInfoItem extends StatelessWidget {
  final String title;
  final String? data;
  const AppInfoItem({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          data ?? "Unknown",
          style: Theme.of(context).textTheme.labelMedium,
        )
      ],
    );
  }
}
