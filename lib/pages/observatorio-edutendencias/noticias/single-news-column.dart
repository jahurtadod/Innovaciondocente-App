import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/classes/noticia.dart';

class SingleNewsColumn extends StatelessWidget {
  final Noticia noticia;

  const SingleNewsColumn({
    Key key,
    this.noticia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Material(
          elevation: 2,
          color: Colors.grey.shade200,
          child: InkWell(
            onTap: () {
              Filters.launchURL(
                  'https://innovaciondocente-utpl.firebaseapp.com/observatorio-edutendencias/noticias/${noticia.id}');
            },
            child: _buildCard(context),
          ),
        ),
      ),
    );
  }

  Container _buildCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /// Image asset
          _buildImage(context),

          /// Details
          _buildDetails(context)
        ],
      ),
    );
  }

  Column _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Text(
          noticia.name,
          style: Theme.of(context).textTheme.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
        SizedBox(height: 5.0),
        Text(
          Filters.date(noticia.created),
          style: Theme.of(context).textTheme.overline,
        ),
        SizedBox(height: 10.0),
        Text(
          noticia.description,
          overflow: TextOverflow.ellipsis,
          maxLines: 6,
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(
            Radius.circular(3.0),
          ),
          image: DecorationImage(
            image: NetworkImage(noticia.img),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
