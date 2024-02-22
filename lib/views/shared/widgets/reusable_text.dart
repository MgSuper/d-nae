import 'package:deenae/views/shared/widgets/export_packages.dart';

class ReusableText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const ReusableText({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.fade,
      textAlign: TextAlign.left,
      softWrap: false,
      style: style,
    );
  }
}
