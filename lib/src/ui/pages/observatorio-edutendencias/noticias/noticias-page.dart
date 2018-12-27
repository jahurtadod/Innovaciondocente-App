import 'dart:async';
import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/models/noticia.dart';
import 'package:innovaciondocente_app/src/resources/filters.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/noticias/double-news-column.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/noticias/single-news-column.dart';
import 'package:innovaciondocente_app/src/ui/widgets/loader.dart';
import 'package:innovaciondocente_app/src/ui/widgets/main-menu.dart';

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
      drawer: MainMenu(
        actualPath: '/observatorio-edutendencias/noticias',
      ),
      body: (this._noticias == null)
          ? Loader()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              itemBuilder: _itemsBuilder,
              itemCount: _listItemCount(this._noticias.length),
            ),
    );
  }

  Widget _itemsBuilder(BuildContext context, int index) {
    if (index % 2 == 0) {
      /// Even cases
      int bottom = _evenCasesIndex(index);
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: DoubleNewsColumn(
          top: _noticias[bottom],
          bottom: _noticias.length - 1 >= bottom + 1 ? _noticias[bottom + 1] : null,
        ),
      );
    }

    /// Odd cases
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SingleNewsColumn(
        noticia: _noticias[_oddCasesIndex(index)],
      ),
    );
  }

  ///  return `number of columns`
  int _listItemCount(int totalItems) {
    return (totalItems % 3 == 0)
        // total number of columns matches totalItems
        ? totalItems ~/ 3 * 2
        // add column for last item
        : (totalItems / 3).ceil() * 2 - 1;
  }

  int _evenCasesIndex(int input) {
    return input ~/ 2 * 3;
  }

  int _oddCasesIndex(int input) {
    assert(input > 0);
    return (input / 2).ceil() * 3 - 1;
  }
}
