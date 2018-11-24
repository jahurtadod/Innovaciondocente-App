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
      appBar: AppBar(
        title: Text('Tip Innovacion'),
      ),
      body: buildListView(context),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget buildListView(BuildContext context) {
    EdgeInsets padding = const EdgeInsets.only(
      top: 20.0,
      left: 20.0,
      right: 20.0,
    );
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // header
          Container(
            padding: padding,
            child: Text(
              tip.name,
              style: Theme.of(context).textTheme.title.copyWith(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
          ),
          // image
          _buildImage(context),
          // chip category
          _buildChip(padding, context),
          // date
          Container(
            padding: padding,
            child: Text(Filters.date(tip.created)),
          ),
          //description
          Padding(
            padding: padding,
            child: Text(
              tip.description,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildChip(EdgeInsets padding, BuildContext context) {
    return Container(
      padding: padding,
      child: Container(
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
      ),
    );
  }

  Padding _buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Stack(
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
      ),
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
