import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  useMaterial3: true,
  primaryColor: AppColors.primaryColor,
  dividerColor: AppColors.primaryColor,
  iconTheme: const IconThemeData(color: AppColors.black),
  appBarTheme: AppBarTheme(backgroundColor: AppColors.bgColor, elevation: 0.0),
);
