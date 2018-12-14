import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/classes/tips-innovacion.dart';

class TipDetail extends StatelessWidget {
  const TipDetail({
    Key key,
    @required this.tip,
  }) : super(key: key);

  final TipInnovacion tip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  CustomScrollView _buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('Tip Innovación'),
          pinned: true,
        ),
        SliverPadding(
          padding: EdgeInsets.all(15.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Text(
                  tip.name,
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 10),
                // image
                _buildImage(context),
                SizedBox(height: 10),
                // chip category
                _buildChip(context),
                SizedBox(height: 10),
                // date
                Text(Filters.date(tip.created)),
                SizedBox(height: 10),
                //description
                Text(
                  tip.description,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildChip(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 2.5,
            horizontal: 5.0,
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
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return Stack(
      children: <Widget>[
        // image
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Theme.of(context).primaryColor,
            image: DecorationImage(
              image: NetworkImage(tip.img),
              fit: BoxFit.cover,
            ),
          ),
          height: 170.0,
        ),
        // image icon
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: EdgeInsets.all(2.0),
            child: Icon(
              Icons.image,
              color: Colors.white,
            ),
          ),
          bottom: 5.0,
          right: 5.0,
        )
      ],
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    Function goto = () {
      Filters.launchURL(tip.link);
    };

    return tip.tag == 'videos'
        ? FloatingActionButton.extended(
            icon: Icon(Icons.play_arrow),
            label: Text("Abrir Video"),
            onPressed: goto,
          )
        : FloatingActionButton.extended(
            icon: Icon(Icons.link),
            label: Text("Abrir Enlace"),
            onPressed: goto,
          );
  }
}
