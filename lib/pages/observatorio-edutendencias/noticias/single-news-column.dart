import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/noticia.dart';

class SingleNewsColumn extends StatelessWidget {
  final Noticia noticia;

  const SingleNewsColumn({
    Key key,
    this.noticia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Image.network(noticia.img),
              Text(
                noticia.name,
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(height: 20.0),
              Text(noticia.description),
            ],
          ),
        ),
      ),
    );
  }
}
