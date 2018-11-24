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
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Card(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    /// Image asset
                    _buildImage(context),

                    /// Details
                    _buildDetails(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
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
        ),
        SizedBox(height: 5.0),
        Row(
          children: <Widget>[
            Text(
              Filters.date(noticia.created),
              style: Theme.of(context).textTheme.overline,
            ),
            SizedBox(width: 3.0,),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 2.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(noticia.description),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return AspectRatio(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(3.0),
          ),
          image: DecorationImage(
            image: NetworkImage(noticia.img),
            fit: BoxFit.cover,
          ),
        ),
      ),
      aspectRatio: 1,
    );
  }
}
