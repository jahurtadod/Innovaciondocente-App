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
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // top card
        Padding(
          padding: EdgeInsetsDirectional.only(start: 10.0),
          child: _NewsCard(
            noticia: top,
          ),
        ),

        // bottom
        Padding(
          padding: EdgeInsetsDirectional.only(end: 10.0),
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
  _NewsCard({
    Key key,
    @required this.noticia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.all(Radius.circular(3.0)),
      child: InkWell(
        onTap: () {},
        child: _buildCard(context),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildDetails(context),
          SizedBox(width: 10.0),
          _buildImg(context),
        ],
      ),
    );
  }

  Container _buildImg(BuildContext context) {
    return Container(
      width: 110.0,
      height: 110.0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        image: DecorationImage(
          image: NetworkImage(noticia.img),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
    );
  }

  Expanded _buildDetails(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
      ),
    );
  }
}
