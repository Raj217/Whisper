part of toast;

class ToastWidget extends StatelessWidget {
  final String text;
  final TextStyle style;
  const ToastWidget({Key? key, required this.text, required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}
