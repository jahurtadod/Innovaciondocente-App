import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/pages/home.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/noticias/noticias.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/tips-innovacion/tips-innovacion.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion/tips-innovacion-database.dart';

class Router {
  static Map<String, WidgetBuilder> appRoutes() {
    Database database = new AppFirestore();

    return {
      '/': (BuildContext context) => Home(),
      '/tips': (BuildContext context) => TipsInnovacionPage(
            database: database,
            stream: database.tipsStream(),
          ),
    //   '/noticias': (BuildContext context) => Noticias(
    //         database: database,
    //         stream: database.tipsStream(),
    //       ),
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
