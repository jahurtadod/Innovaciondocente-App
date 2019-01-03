import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/cafe-cientifico/home/encuentros-page.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/programa-formacion/home/programa-formacion-page.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/noticias/home/noticias-page.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/tips-innovacion/home/tips-innovacion-page.dart';
import 'package:innovaciondocente_app/src/ui/pages/start/presentation/presentation-page.dart';
import 'package:innovaciondocente_app/src/ui/pages/start/start-page.dart';

class Router {
  static Map<String, WidgetBuilder> appRoutes() {
    return {
      '/presentation': (BuildContext context) => PresentationPage(),
      '/': (BuildContext context) => StartPage(),
      '/observatorio-edutendencias/tips': (BuildContext context) => TipsInnovacionPage(),
      '/observatorio-edutendencias/noticias': (BuildContext context) => NoticiasPage(),
      '/formacion-docente/cafe-cientifico/encuentros': (BuildContext context) => EncuentrosPage(),
      '/formacion-docente/programa-formacion': (BuildContext context) => ProgramaFormacionPage(),
    };
  }

  static Route onGenerateRoute(RouteSettings settings) {
    List<String> path = settings.name.split('/');

    if (path[0].isNotEmpty) return null;

    return null;
  }

  static Route appOnUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (BuildContext context) {
      return StartPage();
    });
  }
}
