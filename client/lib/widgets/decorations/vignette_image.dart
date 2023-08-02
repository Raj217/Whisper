import 'package:flutter/material.dart';

class Vignette extends StatelessWidget {
  final Widget child;
  const Vignette({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.black.withOpacity(0.96),
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
        ),
        child,
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(colors: [
              Colors.transparent,
              Colors.transparent,
              Colors.black.withOpacity(0.96),
            ], radius: 1.1),
          ),
        ),
      ],
    );
  }
}
