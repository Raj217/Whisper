import 'package:flutter/material.dart';
import 'filter_section.dart';

class SearchOverlay extends StatefulWidget {
  final bool isOverlayOpen;
  final Widget child;
  final List<FilterSection> sections;
  const SearchOverlay({
    super.key,
    this.isOverlayOpen = false,
    required this.child,
    this.sections = const [],
  });

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Widget overlay = AnimatedContainer(
      duration: kThemeChangeDuration,
      height: screenSize.height,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: widget.isOverlayOpen
            ? Colors.black.withOpacity(0.7)
            : Colors.transparent,
      ),
    );
    return Stack(
      children: [
        widget.child,
        widget.isOverlayOpen ? overlay : IgnorePointer(child: overlay)
      ],
    );
  }
}
