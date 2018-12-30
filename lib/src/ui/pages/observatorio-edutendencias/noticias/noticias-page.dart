import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/database/database.dart';
import 'package:innovaciondocente_app/src/models/noticia.dart';
import 'package:innovaciondocente_app/src/resources/filters.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/noticias/double-news-column.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/noticias/single-news-column.dart';
import 'package:innovaciondocente_app/src/ui/widgets/indev-loader.dart';
import 'package:innovaciondocente_app/src/ui/widgets/main-menu.dart';

class NoticiasPage extends StatelessWidget {
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
      body: StreamBuilder(
        stream: DBProvider.of(context).dbData.noticiasStream,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<List<Noticia>> noticias) =>
            (noticias == null || noticias.data == null)
                ? IndevLoader()
                : ListNoticias(
                    noticias: noticias.data,
                  ),
      ),
    );
  }
}

class ListNoticias extends StatelessWidget {
  final List<Noticia> noticias;

  const ListNoticias({
    Key key,
    @required this.noticias,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      itemBuilder: _itemsBuilder,
      itemCount: _listItemCount(this.noticias.length),
    );
  }

  Widget _itemsBuilder(BuildContext context, int index) {
    if (index % 2 == 0) {
      /// Even cases
      int bottom = _evenCasesIndex(index);
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: DoubleNewsColumn(
          top: noticias[bottom],
          bottom: noticias.length - 1 >= bottom + 1 ? noticias[bottom + 1] : null,
        ),
      );
    }

    /// Odd cases
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SingleNewsColumn(
        noticia: noticias[_oddCasesIndex(index)],
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
