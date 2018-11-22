import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/classes/tips-innovacion.dart';

class SmallCard extends StatelessWidget {
  final TipInnovacion tip;
  final Function onTap;
  const SmallCard({
    Key key,
    @required this.tip,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildDetails(context),
              _buildImg(context),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildDetails(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // title
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                Filters.slice(0, 45, tip.name),
                style: Theme.of(context).textTheme.title,
              ),
            ),
            // description(small)
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(Filters.slice(0, 75, tip.description)),
            ),
            // date
            Container(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                Filters.date(tip.created),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            // chip category
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.radio_button_checked,
                  size: 13.0,
                  color: Theme.of(context).primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    tip.tag.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .overline
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildImg(BuildContext context) {
    return Container(
      height: 110.0,
      width: 110.0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        image: DecorationImage(
          image: NetworkImage(tip.img),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(3.0),
        ),
      ),
    );
  }
}
