import 'package:flutter/material.dart';
import 'package:whisper/packages/rive/rive.dart';

class FilterButton extends StatefulWidget {
  final void Function(bool)? onTap;
  const FilterButton({super.key, this.onTap});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool isMenuOpen = false;
  RiveBoolController filterController = RiveFilterMenuController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (filterController.changeState()) {
          isMenuOpen = !isMenuOpen;
        }
        if (widget.onTap != null) {
          widget.onTap!(isMenuOpen);
        }
      },
      heroTag: "Filter Button Floating Button",
      child: FilterMenu(
        controller: filterController,
      ),
    );
  }
}
