import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/models/innova-tic.dart';
import 'package:innovaciondocente_app/src/resources/colors.dart';
import 'package:innovaciondocente_app/src/resources/filters.dart';

class TipsSection extends StatelessWidget {
  const TipsSection({
    Key key,
    this.innovaTips,
  }) : super(key: key);
  final List<InnovaTic> innovaTips;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
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
                      'https://innovaciondocente-utpl.firebaseapp.com/formacion-docente/programa-formacion/InnovaTips');
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
              (innovaTic) => InnovaTipTile(innovaTic: innovaTic),
            ),
          ),
      ),
    );
  }
}

class InnovaTipTile extends StatelessWidget {
  const InnovaTipTile({
    Key key,
    this.innovaTic,
  }) : super(key: key);

  final InnovaTic innovaTic;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Filters.launchURL('https://youtu.be/${innovaTic.id}');
          },
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: FadeInImage(
                      image:
                          NetworkImage('https://i.ytimg.com/vi/${innovaTic.id}/maxresdefault.jpg'),
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
                        innovaTic.name,
                        style: Theme.of(context).textTheme.subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(height: 4),
                      Text(
                        Filters.date(innovaTic.added),
                        style: Theme.of(context).textTheme.overline,
                      ),
                    ],
                  )),
              SizedBox(width: 10),
              Icon(
                Icons.play_circle_filled,
                color: IndevColors.formacion,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
