import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/models/noticia.dart';
import 'package:innovaciondocente_app/src/resources/colors.dart';
import 'package:innovaciondocente_app/src/resources/filters.dart';
import 'package:innovaciondocente_app/src/ui/pages/observatorio-edutendencias/noticias/_id/noticia-detail-page.dart';

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
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => NoticiaDetailPage(
                          noticia: noticia,
                        )));
          },
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
                      maxLines: 1,
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
        child: Hero(
          tag: noticia.id,
          child: FadeInImage(
            image: NetworkImage(noticia.img),
            placeholder: AssetImage('assets/images/default.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
