import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/cafe-cientifico/encuentros/encuentros-page.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/formacion-docente-page.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/programa-formacion/programa-formacion-page.dart';
import 'package:innovaciondocente_app/pages/home.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/noticias/noticias-page.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/observatorio-edutendencias.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/tips-innovacion/tips-innovacion.dart';
import 'package:innovaciondocente_app/pages/start/presentation/presentation-page.dart';
import 'package:innovaciondocente_app/pages/start/start-page.dart';
import 'package:innovaciondocente_app/services/formacion-docente/cafe-cientifico/encuentros-database.dart';
import 'package:innovaciondocente_app/services/formacion-docente/programa-formacion/cursos-database.dart';
import 'package:innovaciondocente_app/services/formacion-docente/programa-formacion/innova-tip-database.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/noticias/noticias-database.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion/tips-innovacion-database.dart';

class Router {
  static Map<String, WidgetBuilder> appRoutes() {
    return {
      // '/': (BuildContext context) => Home(),
      '/presentation': (BuildContext context) => PresentationPage(),
      '/': (BuildContext context) => StartPage(
            stream: [
              TipsDatabase().getStream(),
              NoticiasDatabase().getStream(),
              EncuentrosCafeCientificoDatabase().getStream(),
              CursosProgramaFormacionDatabase().getStream(),
            ],
          ),
      '/observatorio-edutendencias': (BuildContext context) => ObservatorioEdutendenciasPage(),
      '/observatorio-edutendencias/tips': (BuildContext context) => TipsInnovacionPage(
            stream: TipsDatabase().getStream(),
          ),
      '/observatorio-edutendencias/noticias': (BuildContext context) => NoticiasPage(
            stream: NoticiasDatabase().getStream(),
          ),
      '/formacion-docente/cafe-cientifico/encuentros': (BuildContext context) => EncuentrosPage(
            stream: EncuentrosCafeCientificoDatabase().getStream(),
          ),
      '/formacion-docente': (BuildContext context) => FormacionDocentePage(),
      '/formacion-docente/programa-formacion': (BuildContext context) => ProgramaFormacionPage(
            cursosStream: CursosProgramaFormacionDatabase().getStream(),
            innovaTipsStream: InnovaTipsProgramaFormacionDatabase().getStream(),
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
