import 'package:flutter/material.dart';
import 'package:Ascendere_UTPL/src/models/tip-innovacion.dart';
import 'package:Ascendere_UTPL/src/resources/colors.dart';
import 'package:Ascendere_UTPL/src/resources/filters.dart';

class TipDetail extends StatelessWidget {
  const TipDetail({
    Key key,
    @required this.tip,
  }) : super(key: key);

  final TipInnovacion tip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Tip Innovación'),
            pinned: true,
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: EdgeInsets.all(15.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    // image
                    _buildImage(),
                    SizedBox(height: 10),
                    Text(
                      tip.name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(height: 8),
                    // date
                    Text(Filters.date(tip.created)),
                    SizedBox(height: 10),

                    tip.tag == 'videos'
                        ? RaisedButton(
                            color: IndevColors.observatorio,
                            child: Text(
                              "Abrir Video",
                              style: Theme.of(context).accentTextTheme.button,
                            ),
                            onPressed: () {
                              Filters.launchURL(tip.link);
                            },
                          )
                        : RaisedButton(
                            color: IndevColors.observatorio,
                            child: Text(
                              "Abrir Enlace",
                              style: Theme.of(context).accentTextTheme.button,
                            ),
                            onPressed: () {
                              Filters.launchURL(tip.link);
                            },
                          ),
                    SizedBox(height: 10),
                    //description
                    Text(
                      tip.description,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Hero(
        tag: tip.id,
        child: FadeInImage(
          height: 170.0,
          width: double.infinity,
          image: NetworkImage(tip.img),
          placeholder: AssetImage('assets/images/default.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
