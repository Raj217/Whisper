import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/packages/toast/toast.dart';
import 'package:whisper/packages/rive/rive.dart';
import 'package:whisper/states/screen/screen.dart';
import 'widgets/side_menu.dart';
import 'widgets/main_page.dart';

class BaseScreen extends ConsumerStatefulWidget {
  static const String routeName = "/screenBase";
  const BaseScreen({super.key});

  @override
  ConsumerState createState() => _ScreenBaseState();
}

class _ScreenBaseState extends ConsumerState<BaseScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _rotationController, _scaleController;
  final RiveController hamburgerController = RiveHamburgerMenuController();

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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dynamic arguments = ModalRoute.of(context)?.settings.arguments;
      if (arguments is String?) {
        if (arguments != null) showToast(context: context, text: arguments);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (hamburgerController.changeState()) {
              if (_animationController.value == 0) {
                ref.read(screenProvider.notifier).isMenuOpen = true;
                _animationController.forward();
              } else {
                ref.read(screenProvider.notifier).isMenuOpen = false;
                _animationController.reverse();
              }
            }
          },
          child: IgnorePointer(
            child: HamburgerMenu(controller: hamburgerController),
          ),
        ),
        body: Stack(
          children: [
            const SideMenu(),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_rotationController.value)
                ..scale(_scaleController.value)
                ..translate(_rotationController.value * 180),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const MainPage(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
