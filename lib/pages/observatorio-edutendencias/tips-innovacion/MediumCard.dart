import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/classes/tips-innovacion.dart';

/// Card for tips with big img style
class MediumCard extends StatelessWidget {
  final TipInnovacion tip;
  final Function onTap;
  const MediumCard({
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
          child: Column(
            children: <Widget>[
              // chip category
              _buildChip(context),
              _buildImg(context),
              _buildDetails(context),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildChip(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(
        vertical: 2.5,
        horizontal: 5.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(3.0),
        ),
      ),
      child: Text(
        tip.tag.toUpperCase(),
        style: Theme.of(context).textTheme.overline,
      ),
    );
  }

  Column _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // title
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            Filters.slice(0, 45, tip.name),
            style: Theme.of(context).textTheme.title,
          ),
        ),
        // description
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            Filters.slice(0, 120, tip.description),
            textAlign: TextAlign.justify,
          ),
        ),

        // date
        Text(
          Filters.date(tip.created),
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }

  Container _buildImg(BuildContext context) {
    return Container(
      height: 150.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(3.0),
        ),
        image: DecorationImage(
          image: NetworkImage(tip.img),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
