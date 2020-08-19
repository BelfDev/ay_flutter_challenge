import 'package:ay_flutter_challenge/configs/app_config.dart';
import 'package:ay_flutter_challenge/configs/app_theme.dart';
import 'package:ay_flutter_challenge/routes/route_provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AppContainer());
}

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
