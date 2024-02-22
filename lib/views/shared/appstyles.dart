import 'package:deenae/views/shared/widgets/export_packages.dart';

TextStyle appstyle(double size, Color color, FontWeight fw) {
  return GoogleFonts.poppins(
    fontSize: size.sp,
    color: color,
    fontWeight: fw,
  );
}

TextStyle appstyleWithHt(double size, Color color, FontWeight fw, double ht) {
  return GoogleFonts.poppins(
    fontSize: size.sp,
    color: color,
    fontWeight: fw,
    height: ht,
  );
}
