import 'package:flutter/cupertino.dart';

class WhisperIcon extends StatelessWidget {
  const WhisperIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Hero(
      tag: "Whisper Icon",
      child: Icon(
        CupertinoIcons.moon_fill,
        size: 100,
      ),
    );
  }
}
