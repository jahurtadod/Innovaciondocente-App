import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/pages/home.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/noticias/noticias.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/tips-innovacion/tips-innovacion.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/noticias/noticias-database.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion/tips-innovacion-database.dart';
import 'package:innovaciondocente_app/services/service.dart';

class Router {
  static Map<String, WidgetBuilder> appRoutes() {
    Database tipsDB = TipsDatabase();
    Database noticiasDB = NoticiasDatabase();

    return {
      '/': (BuildContext context) => Home(),
      '/tips': (BuildContext context) => TipsInnovacionPage(
            stream: tipsDB.getStream(),
          ),
      '/noticias': (BuildContext context) => Noticias(
            stream: noticiasDB.getStream(),
          ),
    };
  }

  static Route onGenerateRoute(RouteSettings settings) {
    List<String> path = settings.name.split('/');

    if (path[0].isNotEmpty) return null;

    return null;
  }

  static Route appOnUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (BuildContext context) {
      return Home();
    });
  }
}
