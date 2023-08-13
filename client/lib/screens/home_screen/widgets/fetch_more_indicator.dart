import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:whisper/configs/config.dart';

class FetchMoreIndicator extends StatelessWidget {
  final Widget child;
  final double pullUpSectionHeight;
  final Future<void> Function() fetchFunction;
  const FetchMoreIndicator({
    super.key,
    required this.child,
    required this.fetchFunction,
    this.pullUpSectionHeight = 70,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: fetchFunction,
      trailingScrollIndicatorVisible: false,
      trigger: IndicatorTrigger.trailingEdge,
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        double dy = controller.value * -pullUpSectionHeight;
        return AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return Stack(
                children: [
                  Transform.translate(offset: Offset(0, dy), child: child),
                  Positioned(
                    bottom: -pullUpSectionHeight,
                    left: 0,
                    right: 0,
                    height: pullUpSectionHeight,
                    child: Container(
                      transform: Matrix4.translationValues(0, dy, 0),
                      child: Column(
                        children: [
                          if (controller.isLoading)
                            const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: whiteSwatch,
                                strokeWidth: 5,
                                strokeCap: StrokeCap.round,
                              ),
                            ),
                          if (!controller.isLoading)
                            const Icon(
                              Icons.keyboard_arrow_up,
                              color: whiteSwatch,
                            ),
                          const SizedBox(height: 10),
                          Text(
                            controller.isLoading
                                ? "Loading..."
                                : "Release to load more",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: whiteSwatch),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            });
      },
      child: child,
    );
  }
}
