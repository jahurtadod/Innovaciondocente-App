import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/cafe-cientifico/encuentros-page.dart';
import 'package:innovaciondocente_app/pages/home.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/noticias/noticias-page.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/tips-innovacion/tips-innovacion.dart';
import 'package:innovaciondocente_app/services/formacion-docente/cafe-cientifico/encuentros-database.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/noticias/noticias-database.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion/tips-innovacion-database.dart';

class Router {
  static Map<String, WidgetBuilder> appRoutes() {
    return {
      '/': (BuildContext context) => Home(),
      '/tips': (BuildContext context) => TipsInnovacionPage(
            stream: TipsDatabase().getStream(),
          ),
      '/noticias': (BuildContext context) => NoticiasPage(
            stream: NoticiasDatabase().getStream(),
          ),
      '/cafe-cientifico/encuentros': (BuildContext context) => EncuentrosPage(
            stream: EncuentrosCafeCientificoDatabase().getStream(),
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
