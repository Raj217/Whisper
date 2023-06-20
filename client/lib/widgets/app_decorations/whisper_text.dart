import 'package:flutter/material.dart';

class WhisperText extends StatelessWidget {
  const WhisperText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Whisper",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 10),
        Text(
          "Unveiling the Subtle Beauty of Images,\nEchoing Melodies of the Future.",
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
