import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'core/utils/utils.dart';
import 'shared/themes/app_theme.dart';
import 'features/calculator/presentation/view/screens/calculator_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  
  // Get saved theme mode
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  
  const MyApp({super.key, this.savedThemeMode});
  
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'VAT Calculator',
        theme: theme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: const CalculatorScreen(),
      ),
    );
  }
}
