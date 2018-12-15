import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/classes/noticia.dart';

class DoubleNewsColumn extends StatelessWidget {
  final Noticia top, bottom;

  const DoubleNewsColumn({
    Key key,
    @required this.top,
    @required this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _NewsCard(
            noticia: top,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: bottom != null
              ? _NewsCard(
                  noticia: bottom,
                )
              : Container(),
        ),
      ],
    );
  }
}

class _NewsCard extends StatelessWidget {
  final Noticia noticia;

  const _NewsCard({
    Key key,
    this.noticia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Colors.grey.shade200,
      child: InkWell(
        onTap: () {
          Filters.launchURL(
              'https://innovaciondocente-utpl.firebaseapp.com/observatorio-edutendencias/noticias/${noticia.id}');
        },
        child: _buildCard(context),
      ),
    );
  }

  Container _buildCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          /// Image asset
          _buildImage(context),

          /// Details
          _buildDetails(context)
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Text(
          noticia.name,
          style: Theme.of(context).textTheme.subtitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        SizedBox(height: 3.0),
        Text(
          Filters.date(noticia.created),
          style: Theme.of(context).textTheme.overline,
        ),
        SizedBox(height: 5.0),
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
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(3.0),
        ),
        child: FadeInImage(
          image: NetworkImage(noticia.img),
          placeholder: AssetImage('assets/images/default.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
