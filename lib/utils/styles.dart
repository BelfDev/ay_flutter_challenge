import 'package:ay_flutter_challenge/configs/app_theme.dart';
import 'package:ay_flutter_challenge/utils/theme_colors.dart';
import 'package:flutter/material.dart';

// TODO: Implement dark mode
/// Utility class to provide widget styles based on the [AppTheme].
class Styles {
  static ThemeData _theme;

  Styles._();

  /// Returns a [Styles] object that provides widget styles
  /// based on the closest [Theme] instance that encloses the given
  /// context.
  static Styles of(BuildContext context) {
    _theme = AppTheme.of(context);
    return Styles._();
  }

  /// Returns the App's gradient styles.
  _AppGradients get gradients => _AppGradients(_theme);

  /// Returns the App's text styles.
  _AppTexts get texts => _AppTexts(_theme);

  /// Returns the App's divider color.
  Color get dividerColor => ThemeColors.greyShade250;

  Color get placeholderIconColor => ThemeColors.lightGrey;
}

abstract class _ThemedStyle {
  @protected
  final ThemeData theme;

  const _ThemedStyle(this.theme);
}

class _AppGradients extends _ThemedStyle {
  final section = const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [ThemeColors.greyShade300, ThemeColors.greyShade250]);

  const _AppGradients(theme) : super(theme);
}

class _AppTexts extends _ThemedStyle {
  const _AppTexts(theme) : super(theme);

  TextStyle get sectionTile => theme.textTheme.headline2;

  TextStyle get itemTile => theme.textTheme.bodyText1;

  TextStyle get error =>
      theme.textTheme.bodyText1.apply(color: ThemeColors.grey);
}
