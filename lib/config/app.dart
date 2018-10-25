import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/config/theme.dart';

class InnovaciondocenteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Innovacion Docente',
      theme: id_buildTheme(),
      home: Container(),
    );
  }
}
