import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/models/noticia.dart';
import 'package:innovaciondocente_app/src/resources/colors.dart';
import 'package:innovaciondocente_app/src/resources/filters.dart';

class NoticiaCard extends StatelessWidget {
  const NoticiaCard({
    Key key,
    @required this.noticia,
  }) : super(key: key);

  final Noticia noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7.5),
      child: Card(
        elevation: 2,
        color: Colors.grey.shade100,
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildImage(context),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      noticia.name,
                      style: Theme.of(context).textTheme.headline,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    Text(
                      Filters.date(noticia.date),
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: <Widget>[
            FadeInImage(
              image: NetworkImage(noticia.img),
              placeholder: AssetImage('assets/images/default.png'),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.black87,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 15,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.bookmark_border,
                    color: IndevColors.observatorio,
                    size: 18,
                  ),
                  SizedBox(width: 3),
                  Container(
                    padding: const EdgeInsets.only(left: 3, bottom: 1),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: IndevColors.observatorio),
                        left: BorderSide(color: IndevColors.observatorio),
                      ),
                    ),
                    child: Text(
                      "Noticia",
                      style: Theme.of(context).accentTextTheme.subhead,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
