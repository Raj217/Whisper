part of toast;

void showToast({
  required BuildContext context,
  required String text,
  Duration duration = const Duration(milliseconds: 1500),
  double widthFactor = 0.7,
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  TextStyle? style,
}) {
  assert(0 < widthFactor && widthFactor < 1,
      "widthFactor must be between 0 and 1");

  style ??= Theme.of(context)
      .textTheme
      .labelMedium
      ?.copyWith(color: Theme.of(context).scaffoldBackgroundColor);

  double width =
      WidgetUtils.textSize(text, style!).width + padding.left + padding.right;
  if (width >= MediaQuery.of(context).size.width) {
    width = MediaQuery.of(context).size.width - margin.left - margin.right;
  }

  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ToastWidget(text: text, style: style!),
        duration: duration,
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        width: width,
        padding: padding,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  });
}
