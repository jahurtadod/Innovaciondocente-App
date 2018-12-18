import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/config/colors.dart';
import 'package:innovaciondocente_app/services/formacion-docente/programa-formacion/innova-tip.dart';

class TipsSection extends StatelessWidget {
  const TipsSection({
    Key key,
    this.innovaTips,
  }) : super(key: key);
  final List<InnovaTip> innovaTips;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "InnovaTips",
                style: Theme.of(context).textTheme.headline,
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Filters.launchURL(
                      'https://innovaciondocente-utpl.firebaseapp.com/formacion-docente/programa-formacion/potencia-formacion');
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      "Ver Todos",
                      style: Theme.of(context).textTheme.overline,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 18,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 7.5)
        ]..addAll(
            innovaTips.map(
              (tip) => InnovaTipTile(innovaTip: tip),
            ),
          ),
      ),
    );
  }
}

class InnovaTipTile extends StatelessWidget {
  const InnovaTipTile({
    Key key,
    this.innovaTip,
  }) : super(key: key);

  final InnovaTip innovaTip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: FadeInImage(
                  image: NetworkImage('https://i.ytimg.com/vi/${innovaTip.id}/maxresdefault.jpg'),
                  placeholder: AssetImage('assets/images/default.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    innovaTip.name,
                    style: Theme.of(context).textTheme.subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 4),
                  Text(
                    Filters.date(innovaTip.added),
                    style: Theme.of(context).textTheme.overline,
                  ),
                ],
              )),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              'Ver',
              style: Theme.of(context).textTheme.overline,
            ),
          )
        ],
      ),
    );
  }
}
