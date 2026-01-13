import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryPurple,
    brightness: Brightness.light,
  ),
  primaryColor: AppColors.primaryPurple,
  scaffoldBackgroundColor: AppColors.lightPurpleBg,
  cardColor: Colors.white,
  dividerColor: AppColors.primaryPurple.withValues(alpha: 0.2),
  iconTheme: const IconThemeData(color: AppColors.black),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.lightPurpleBg,
    elevation: 0.0,
    iconTheme: const IconThemeData(color: AppColors.black),
  ),
  textTheme: GoogleFonts.interTextTheme(),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryPurple,
    brightness: Brightness.dark,
  ),
  primaryColor: AppColors.primaryPurple,
  scaffoldBackgroundColor: AppColors.darkPurpleBg,
  cardColor: AppColors.darkCardBg,
  dividerColor: AppColors.primaryPurple.withOpacity(0.3),
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkPurpleBg,
    elevation: 0.0,
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
);
