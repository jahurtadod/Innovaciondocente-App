import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/programa-formacion/courses-section.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/programa-formacion/header-section.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/programa-formacion/tips-section.dart';
import 'package:innovaciondocente_app/pages/share/loader.dart';
import 'package:innovaciondocente_app/services/formacion-docente/programa-formacion/curso.dart';
import 'package:innovaciondocente_app/services/formacion-docente/programa-formacion/innova-tip.dart';

class ProgramaFormacionPage extends StatefulWidget {
  final Stream<List> cursosStream, innovaTipsStream;

  const ProgramaFormacionPage({
    Key key,
    this.cursosStream,
    this.innovaTipsStream,
  }) : super(key: key);

  @override
  _ProgramaFormacionPageState createState() => _ProgramaFormacionPageState();
}

class _ProgramaFormacionPageState extends State<ProgramaFormacionPage> {
  List<Curso> _cursos;
  List<InnovaTip> _innovaTips;
  StreamSubscription<List<Curso>> _cursosSubs;
  StreamSubscription<List<InnovaTip>> _innovaTipsSubs;

  @override
  void initState() {
    super.initState();
    this._cursosSubs = widget.cursosStream.listen((cursos) {
      setState(() {
        this._cursos = cursos;
      });
    });
    this._innovaTipsSubs = widget.innovaTipsStream.listen((innovaTips) {
      setState(() {
        this._innovaTips = innovaTips;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    this._cursosSubs.cancel();
    this._innovaTipsSubs.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (this._cursos == null || this._innovaTips == null)
          ? Loader()
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  snap: true,
                  floating: true,
                  title: Text("Formación Docente"),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    HeaderSection(),
                    CourseSection(cursos: _cursos),
                    TipsSection(innovaTips: _innovaTips),
                  ]),
                )
              ],
            ),
    );
  }
}
