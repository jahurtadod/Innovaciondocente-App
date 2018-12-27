import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/database/cursos.database.dart';
import 'package:innovaciondocente_app/src/database/encuentros.database.dart';
import 'package:innovaciondocente_app/src/database/innova-tip.database.dart';
import 'package:innovaciondocente_app/src/database/noticias-database.dart';
import 'package:innovaciondocente_app/src/database/tips-innovacion-database.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/cafe-cientifico/home/encuentros-page.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/programa-formacion/home/programa-formacion-page.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/noticias/noticias-page.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/tips-innovacion/tips-innovacion.dart';
import 'package:innovaciondocente_app/src/ui/pages/start/presentation/presentation-page.dart';
import 'package:innovaciondocente_app/src/ui/pages/start/start-page.dart';

class Router {
  static Map<String, WidgetBuilder> appRoutes() {
    return {
      // '/': (BuildContext context) => Home(),
      '/presentation': (BuildContext context) => PresentationPage(),
      '/': (BuildContext context) => StartPage(
            stream: [
              TipsInnovacionDatabase().getStream(),
              NoticiasDatabase().getStream(),
              EncuentrosCafeCientificoDatabase().getStream(),
              CursosProgramaFormacionDatabase().getStream(),
            ],
          ),
      '/observatorio-edutendencias/tips': (BuildContext context) => TipsInnovacionPage(
            stream: TipsInnovacionDatabase().getStream(),
          ),
      '/observatorio-edutendencias/noticias': (BuildContext context) => NoticiasPage(),
      '/formacion-docente/cafe-cientifico/encuentros': (BuildContext context) => EncuentrosPage(
            stream: EncuentrosCafeCientificoDatabase().getStream(),
          ),
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
      return StartPage(
        stream: [
          TipsInnovacionDatabase().getStream(),
          NoticiasDatabase().getStream(),
          EncuentrosCafeCientificoDatabase().getStream(),
          CursosProgramaFormacionDatabase().getStream(),
        ],
      );
    });
  }
}
