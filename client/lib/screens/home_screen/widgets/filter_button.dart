import 'package:flutter/material.dart';
import 'package:whisper/packages/rive/rive.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool isMenuOpen = false;
  RiveBoolController filterController = RiveFilterMenuController();

  set setMenu(bool isMenuOpen) {
    setState(() {
      this.isMenuOpen = isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        filterController.changeState();
      },
      heroTag: "Filter Button Floating Button",
      child: FilterMenu(
        controller: filterController,
      ),
    );
  }
}
