import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/database/database.dart';
import 'package:innovaciondocente_app/src/models/noticia.dart';
import 'package:innovaciondocente_app/src/resources/filters.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/noticias/home/noticia-card.dart';
import 'package:innovaciondocente_app/src/ui/widgets/indev-loader.dart';
import 'package:innovaciondocente_app/src/ui/widgets/main-menu.dart';

class NoticiasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainMenu(
        actualPath: '/observatorio-edutendencias/noticias',
      ),
      body: StreamBuilder(
        stream: DBProvider.of(context).dbData.noticiasStream,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<List<Noticia>> snap) =>
            (snap == null || snap.data == null)
                ? IndevLoader()
                : NoticiasList(
                    noticias: snap.data,
                  ),
      ),
    );
  }
}

class NoticiasList extends StatelessWidget {
  final List<Noticia> noticias;

  const NoticiasList({
    Key key,
    @required this.noticias,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
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
        SliverPadding(
          padding: const EdgeInsets.all(7.5),
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int i) => NoticiaCard(noticia: noticias[i]),
            childCount: noticias.length,
          )),
        )
      ],
    );
  }
}
