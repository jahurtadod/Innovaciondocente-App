import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/cafe-cientifico/encuentros/encuentros-page.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/programa-formacion/cursos-page.dart';
import 'package:innovaciondocente_app/pages/home.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/noticias/noticias-page.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/tips-innovacion/tips-innovacion.dart';
import 'package:innovaciondocente_app/pages/start/presentation/presentation-page.dart';
import 'package:innovaciondocente_app/pages/start/start-page.dart';
import 'package:innovaciondocente_app/services/formacion-docente/cafe-cientifico/encuentros-database.dart';
import 'package:innovaciondocente_app/services/formacion-docente/programa-formacion/cursos-database.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/noticias/noticias-database.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion/tips-innovacion-database.dart';

class Router {
  static Map<String, WidgetBuilder> appRoutes() {
    return {
      '/': (BuildContext context) => Home(),
      '/start': (BuildContext context) => StartPage(
            stream: [
              TipsDatabase().getStream(),
              NoticiasDatabase().getStream(),
              EncuentrosCafeCientificoDatabase().getStream(),
              CursoProgramaFormacionDatabase().getStream(),
            ],
          ),
      '/start/presentation': (BuildContext context) => PresentationPage(),
      '/tips': (BuildContext context) => TipsInnovacionPage(
            stream: TipsDatabase().getStream(),
          ),
      '/noticias': (BuildContext context) => NoticiasPage(
            stream: NoticiasDatabase().getStream(),
          ),
      '/cafe-cientifico/encuentros': (BuildContext context) => EncuentrosPage(
            stream: EncuentrosCafeCientificoDatabase().getStream(),
          ),
      '/programa-formacion/cursos': (BuildContext context) => CursosPage(
            stream: CursoProgramaFormacionDatabase().getStream(),
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
