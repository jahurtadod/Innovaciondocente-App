import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/config/routes.dart';
import 'package:innovaciondocente_app/config/theme.dart';

class InnovaciondocenteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debug config
      debugShowCheckedModeBanner: false,

      title: 'Innovacion Docente',
      theme: Theme2(),
      // theme: ID_buildTheme(),
      routes: Router.appRoutes(),
      onGenerateRoute: Router.onGenerateRoute,
      onUnknownRoute: Router.appOnUnknownRoute,
    );
  }
}
