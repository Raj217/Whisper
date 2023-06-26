import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/screens/screens.dart';
import 'package:whisper/widgets/rive/rive.dart';
import 'widgets/side_menu.dart';

class ScreenBase extends ConsumerStatefulWidget {
  static const String routeName = "/screenBase";
  const ScreenBase({super.key});

  @override
  ConsumerState createState() => _ScreenBaseState();
}

class _ScreenBaseState extends ConsumerState<ScreenBase>
    with SingleTickerProviderStateMixin {
  List<Widget> screens = [
    const HomeScreen(),
  ];
  bool _isMenuOpen = false;
  late final AnimationController _animationController;
  late final Animation<double> _rotationController, _scaleController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: kThemeAnimationDuration)
          ..addListener(() {
            setState(() {});
          });
    _rotationController = Tween<double>(
      begin: 0,
      end: 0.9,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _scaleController = Tween<double>(
      begin: 1,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: HamburgerMenu(
          onStateChange: (bool isMenuOpen) {
            if (_animationController.value == 0) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          },
        ),
      ),
      body: Stack(
        children: [
          SideMenu(),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_rotationController.value)
              ..scale(_scaleController.value)
              ..translate(_rotationController.value * 180),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: HomeScreen(),
            ),
          )
        ],
      ),
    );
  }
}
