import 'package:deenae/views/shared/widgets/export.dart';
import 'package:deenae/views/shared/widgets/export_packages.dart';

class CheckoutButton extends StatelessWidget {
  final String label;
  final void Function()? onTap;
  const CheckoutButton({
    Key? key,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(
          8.0,
        ),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: ReusableText(
              text: label,
              style: appstyle(20, Colors.white, FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
