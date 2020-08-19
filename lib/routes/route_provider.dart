import 'package:ay_flutter_challenge/configs/app_config.dart';
import 'package:ay_flutter_challenge/routes/contact_detail_route.dart';
import 'package:ay_flutter_challenge/routes/contact_list_route.dart';
import 'package:flutter/material.dart';

class RouteProvider {
  static final Map<String, WidgetBuilder> _routes = {
    ContactListRoute.id: (context) => ContactListRoute(),
    ContactDetail.id: (context) => ContactDetail(),
  };

  RouteProvider._();

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
