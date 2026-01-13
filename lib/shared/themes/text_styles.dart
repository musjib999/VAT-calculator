import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTextStyle {
  static TextStyle title = GoogleFonts.inter(
    fontSize: 29,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subTitle = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle appTitle = GoogleFonts.inter(
    fontSize: 20,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headline = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static TextStyle buttonTitle = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static TextStyle body = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.normal,
  );
  static TextStyle label = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );
}

Widget labelText(String label) {
  return Text(label, style: AppTextStyle.label);
}
