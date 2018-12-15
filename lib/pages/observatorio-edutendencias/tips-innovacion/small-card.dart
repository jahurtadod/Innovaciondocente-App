import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/classes/tips-innovacion.dart';

class SmallCard extends StatelessWidget {
  final TipInnovacion tip;
  const SmallCard({
    Key key,
    @required this.tip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildDetails(context),
          SizedBox(width: 15.0),
          _buildImg(context),
        ],
      ),
    );
  }

  Expanded _buildDetails(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // title
          Text(
            tip.name,
            style: Theme.of(context).textTheme.subtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          // description(small)
          Text(
            tip.description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10),
          // date
          Text(
            Filters.date(tip.created),
            style: Theme.of(context).textTheme.caption,
          ),
          SizedBox(height: 10),
          // chip category
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.radio_button_checked,
                size: 13.0,
                color: Theme.of(context).accentColor,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  tip.tag.toUpperCase(),
                  style: Theme.of(context)
                      .accentTextTheme
                      .overline
                      .copyWith(color: Theme.of(context).accentColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImg(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(3.0),
      ),
      child: Hero(
        tag: tip.id,
        child: FadeInImage(
          height: 110.0,
          width: 110.0,
          image: NetworkImage(tip.img),
          placeholder: AssetImage('assets/images/default.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
