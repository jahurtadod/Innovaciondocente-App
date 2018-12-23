import 'package:flutter/src/widgets/icon_data.dart';

class IndevSection {
  final String name;
  final List<IndevRoute> routes;

  IndevSection({
    this.name,
    this.routes,
  });
}

class IndevRoute {
  final String name;
  final String route;
  final bool active;
  final IconData icon;

  IndevRoute({
    this.name,
    this.route,
    String path,
    this.icon,
  }) : active = path == route;
}
