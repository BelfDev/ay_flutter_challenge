import 'package:ay_flutter_challenge/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData of(BuildContext context) {
    final baseTheme = Theme.of(context);
    return baseTheme.copyWith(
      primaryColor: ThemeColors.grey,
      accentColor: ThemeColors.brown,
      scaffoldBackgroundColor: ThemeColors.smoothWhite,
      appBarTheme: AppBarTheme(
        color: ThemeColors.grey,
        iconTheme: IconThemeData(
          color: ThemeColors.white,
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: ThemeColors.darkGray,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
