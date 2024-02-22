import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';

class CategoryBtn extends StatelessWidget {
  final void Function()? onPress;
  final Color buttonColor;
  final String label;
  const CategoryBtn({
    Key? key,
    this.onPress,
    required this.buttonColor,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.255,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: buttonColor,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(9.0),
          ),
        ),
        child: Center(
          child: ReusableText(
            text: label,
            style: appstyle(20, buttonColor, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
