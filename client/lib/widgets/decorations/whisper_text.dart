import 'package:flutter/material.dart';

class WhisperText extends StatelessWidget {
  final TextStyle? mainTextStyle;
  final bool showMessage;
  const WhisperText({Key? key, this.mainTextStyle, this.showMessage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Whisper",
          style: mainTextStyle ??
              Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
        ),
        if (showMessage) const SizedBox(height: 10),
        if (showMessage)
          Text(
            "Unveiling the Subtle Beauty of Images,\nEchoing Melodies of the Future.",
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          )
      ],
    );
  }
}
