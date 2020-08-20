import 'package:ay_flutter_challenge/configs/app_config.dart';
import 'package:ay_flutter_challenge/configs/app_theme.dart';
import 'package:ay_flutter_challenge/routes/route_provider.dart';
import 'package:flutter/material.dart';

/// The App's entry-point. Runs the [AppContainer] widget defined below.
void main() {
  runApp(AppContainer());
}

/// A [StatelessWidget] that provides app-wide configurations.
/// Properties include:
/// - Title
/// - Theme
/// - Routes
class AppContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appTitle,
      theme: AppTheme.of(context),
      onGenerateRoute: RouteProvider.generateRoutes(context),
    );
  }
}
