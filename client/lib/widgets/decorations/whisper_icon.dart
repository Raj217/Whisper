import 'package:flutter/cupertino.dart';

class WhisperIcon extends StatelessWidget {
  final double size;
  const WhisperIcon({Key? key, this.size = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "Whisper Icon",
      child: Icon(
        CupertinoIcons.moon_fill,
        size: size,
      ),
    );
  }
}
