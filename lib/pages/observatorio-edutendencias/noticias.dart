import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/layouts/default.dart';

import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion-database.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion.dart';

class Noticias extends StatefulWidget {
  final Database database;
  final Stream<List> stream;

  Noticias({this.database, this.stream});

  @override
  _NoticiasState createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  List<TipInnovacion> _tips;

  StreamSubscription _subs;

  @override
  void initState() {
    super.initState();
    this._subs = widget.stream.listen((tips) {
      setState(() {
        this._tips = tips;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: SafeArea(
        child: ListView.builder(
          itemCount: _tips.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_tips[index].name),
            );
          },
        ),
      ),
    );
  }
}
