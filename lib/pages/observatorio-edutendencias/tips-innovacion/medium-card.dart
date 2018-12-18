import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/classes/tips-innovacion.dart';

/// Card for tips with big img style
class MediumCard extends StatelessWidget {
  final TipInnovacion tip;
  const MediumCard({
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
      child: Column(
        children: <Widget>[
          _buildChip(context),
          SizedBox(height: 10.0),
          _buildImg(context),
          SizedBox(height: 10.0),
          _buildDetails(context),
        ],
      ),
    );
  }

  Container _buildChip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).accentColor,
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
        Text(
          tip.name,
          style: Theme.of(context).textTheme.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        SizedBox(height: 10.0),
        // description
        Text(
          tip.description,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ),
        SizedBox(height: 10.0),
        // date
        Text(
          Filters.date(tip.created),
          style: Theme.of(context).textTheme.caption,
        ),
      ],
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
          height: 150.0,
          width: double.infinity,
          image: NetworkImage(tip.img),
          placeholder: AssetImage('assets/images/default.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
