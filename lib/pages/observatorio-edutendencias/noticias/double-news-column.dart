import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/noticia.dart';

class DoubleNewsColumn extends StatelessWidget {
  final Noticia top;
  final Noticia bottom;

  const DoubleNewsColumn({
    Key key,
    @required this.top,
    @required this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewsCard(
          noticia: top,
        ),
        bottom != null
            ? NewsCard(
                noticia: bottom,
              )
            : Expanded(
                child: Container(),
              ),
      ],
    );
  }
}

class NewsCard extends StatelessWidget {
  final Noticia noticia;
  NewsCard({
    Key key,
    @required this.noticia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Center(
          child: Text(noticia.name),
        ),
      ),
    );
  }
}
