import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/services/formacion-docente/programa-formacion/curso.dart';

class CursosPage extends StatefulWidget {
  final Stream<List> stream;

  const CursosPage({Key key, this.stream}) : super(key: key);

  @override
  _CursosPageState createState() => _CursosPageState();
}

class _CursosPageState extends State<CursosPage> {
  List<Curso> _cursos;
  StreamSubscription<List<Curso>> _subs;

  @override
  void initState() {
    super.initState();
    this._subs = widget.stream.listen((cursos) {
      setState(() {
        print(cursos);
        this._cursos = cursos;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    this._subs.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: this
            ._cursos
            .map((val) => Container(
                  child: Text(val.name),
                ))
            .toList(),
      ),
    );
  }
}
