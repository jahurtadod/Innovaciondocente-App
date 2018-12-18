import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/programa-formacion/courses-section.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/programa-formacion/header-section.dart';
import 'package:innovaciondocente_app/services/formacion-docente/programa-formacion/curso.dart';

class ProgramaFormacionPage extends StatefulWidget {
  final Stream<List> stream;

  const ProgramaFormacionPage({Key key, this.stream}) : super(key: key);

  @override
  _ProgramaFormacionPageState createState() => _ProgramaFormacionPageState();
}

class _ProgramaFormacionPageState extends State<ProgramaFormacionPage> {
  List<Curso> _cursos;
  StreamSubscription<List<Curso>> _subs;

  @override
  void initState() {
    super.initState();
    this._subs = widget.stream.listen((cursos) {
      setState(() {
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            forceElevated: true,
            title: Text("Formación Docente"),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              HeaderSection(),
              CourseSection(cursos: _cursos),
              CourseSection(cursos: _cursos),
              CourseSection(cursos: _cursos),
              CourseSection(cursos: _cursos),
            ]),
          )
        ],
      ),
    );
  }
}

