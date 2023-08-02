import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';

class Vignette extends StatelessWidget {
  final Widget child;
  const Vignette({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: black,
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
        ),
        child,
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
              Colors.transparent,
              Colors.transparent,
              black,
            ], radius: 1.1),
          ),
        ),
      ],
    );
  }
}
