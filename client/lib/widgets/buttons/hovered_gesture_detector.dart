part of custom_buttons;

class HoveredGestureDetector extends StatelessWidget {
  final void Function(PointerEnterEvent)? onEntry;
  final void Function(PointerExitEvent)? onExit;
  final void Function(PointerHoverEvent)? onHover;
  final void Function()? onTap;
  final HitTestBehavior? behavior;
  final Widget? child;
  const HoveredGestureDetector({
    super.key,
    this.onEntry,
    this.onExit,
    this.onHover,
    this.onTap,
    this.behavior,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: onEntry,
      onExit: onExit,
      cursor: SystemMouseCursors.click,
      onHover: onHover,
      child: GestureDetector(
        onTap: onTap,
        behavior: behavior,
        child: child,
      ),
    );
  }
}
