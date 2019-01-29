import 'package:flutter/material.dart';
import 'package:Ascendere_UTPL/src/models/noticia.dart';
import 'package:Ascendere_UTPL/src/resources/colors.dart';
import 'package:Ascendere_UTPL/src/resources/filters.dart';

class NoticiaDetailPage extends StatelessWidget {
  final Noticia noticia;

  const NoticiaDetailPage({Key key, this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: MediaQuery.of(context).size.width * 9 / 16,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Hero(
                tag: noticia.id,
                child: FadeInImage(
                  image: NetworkImage(noticia.img),
                  placeholder: AssetImage('assets/images/default.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          /// body
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: const EdgeInsets.all(15.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          noticia.name,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      CloseButton()
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    Filters.date(noticia.date),
                    style: Theme.of(context).textTheme.overline,
                  ),
                  Divider(),
                  RaisedButton(
                    child: Text(
                      'Ver Noticia',
                      style: Theme.of(context).accentTextTheme.button,
                    ),
                    onPressed: () {
                      Filters.launchURL(
                          'https://innovaciondocente-utpl.firebaseapp.com/observatorio-edutendencias/noticias/${noticia.id}');
                    },
                    color: IndevColors.observatorio,
                  ),
                  SizedBox(height: 10),
                  Text(noticia.description),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
