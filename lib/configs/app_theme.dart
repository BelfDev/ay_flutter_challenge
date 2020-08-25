import 'package:ay_flutter_challenge/utils/theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A class that encapsulates the App's material [Theme].
class AppTheme {
  static const double _h1 = 20;
  static const double _h2 = 18;
  static const double _b1 = 16;

  AppTheme._();

  /// Builds a custom [ThemeData] based on the closest [Theme] instance
  /// that encloses the given context.
  static ThemeData of(BuildContext context) {
    final baseTheme = Theme.of(context);
    return baseTheme.copyWith(
      primaryColor: ThemeColors.grey,
      accentColor: ThemeColors.brown,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: ThemeColors.darkBrown,
      ),
      cursorColor: ThemeColors.darkBrown,
      scaffoldBackgroundColor: ThemeColors.smoothWhite,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(fontSize: _h2, color: ThemeColors.greyShade250),
      ),
      appBarTheme: AppBarTheme(
        color: ThemeColors.smoothBlack,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          color: ThemeColors.darkGray,
          fontSize: _h1,
        ),
        headline2: TextStyle(
            color: ThemeColors.smoothBlack,
            fontSize: _h2,
            fontWeight: FontWeight.w600),
        bodyText1: TextStyle(
            color: ThemeColors.smoothBlack,
            fontSize: _b1,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
