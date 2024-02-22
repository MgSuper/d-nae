import 'package:deenae/views/shared/widgets/export_packages.dart';

class NewCoffees extends StatelessWidget {
  final String imageUrl;
  final void Function()? onTap;
  const NewCoffees({
    Key? key,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100.h,
        width: 104.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16.0.h),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 0.8,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          // 'https://www.clipartmax.com/png/full/30-303869_splash-coffee-cups-download-vector-coffee-png.png',
        ),
      ),
    );
  }
}
