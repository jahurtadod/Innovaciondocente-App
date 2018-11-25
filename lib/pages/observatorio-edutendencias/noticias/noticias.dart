import 'dart:async';
import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/classes/noticia.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/noticias/asymmetric-view.dart';

class NoticiasPage extends StatefulWidget {
  final Stream<List> stream;

  NoticiasPage({this.stream});

  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  List<Noticia> _noticias;
  StreamSubscription<List<Noticia>> _subs;

  @override
  void initState() {
    super.initState();
    this._subs = widget.stream.listen((noticias) {
      setState(() {
        this._noticias = noticias;
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
      appBar: AppBar(
        title: Text("Noticias"),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.launch),
            tooltip: "Ver todos los Tips",
            onPressed: () {
              Filters.launchURL(
                  'https://innovaciondocente-utpl.firebaseapp.com/observatorio-edutendencias/noticias');
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100.0,
        color: Theme.of(context).accentColor,
      ),
      body: (this._noticias == null) ? Text("Loading") : AsymmetricView(noticias: this._noticias),
    );
  }
}
