import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/database/database.dart';
import 'package:innovaciondocente_app/src/models/noticia.dart';
import 'package:innovaciondocente_app/src/resources/filters.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/noticias/home/noticias-list.dart';
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
                : CustomScrollView(
                    slivers: <Widget>[
                      _buildSliverAppBar(),
                      SliverPadding(
                        padding: const EdgeInsets.all(7.5),
                        sliver: SliverList(
                          delegate: NoticiasList(noticias: snap.data),
                        ),
                      )
                    ],
                  ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      title: Text("Noticias"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.open_in_browser),
          tooltip: "Ver todas las Noticias",
          onPressed: () {
            Filters.launchURL(
                'https://innovaciondocente-utpl.firebaseapp.com/observatorio-edutendencias/noticias');
          },
        ),
      ],
    );
  }
}
