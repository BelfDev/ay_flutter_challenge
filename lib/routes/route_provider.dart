import 'package:ay_flutter_challenge/configs/app_config.dart';
import 'package:ay_flutter_challenge/routes/contact_book_route.dart';
import 'package:ay_flutter_challenge/routes/contact_detail_route.dart';
import 'package:flutter/material.dart';

/// A class that registers and generates App [Route]s
class RouteProvider {
  static final Map<String, WidgetBuilder> _routes = {
    ContactBookRoute.id: (context) => ContactBookRoute(),
    ContactDetailRoute.id: (context) => ContactDetailRoute(),
  };

  RouteProvider._();

  /// Generates [MaterialPageRoute]s based on the registered map of routes.
  /// This method is often used in conjunction with the [MaterialApp] widget
  /// configuration (onGenerateRoute). In case of '/' path name, the route
  /// is resolved to the initial route id registered in the [AppConfig].
  static RouteFactory generateRoutes(BuildContext context) =>
      (RouteSettings settings) {
        final String routeName =
            settings.name == '/' ? AppConfig.initialRoute : settings.name;
        final WidgetBuilder widgetBuilder = _routes[routeName];
        return MaterialPageRoute(
          settings: settings,
          builder: widgetBuilder,
        );
      };
}
