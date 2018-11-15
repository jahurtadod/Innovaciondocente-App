import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class TipDetail extends StatelessWidget {
  const TipDetail({
    Key key,
    @required this.tip,
  }) : super(key: key);

  final TipInnovacion tip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildListView(context),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  BottomAppBar _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  ListView buildListView(BuildContext context) {
    EdgeInsets padding = const EdgeInsets.only(
      top: 20.0,
      left: 20.0,
      right: 20.0,
    );
    return ListView(
      children: <Widget>[
        // header
        Padding(
          padding: padding,
          child: Text(
            tip.name,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        // date
        Padding(
          padding: padding,
          child: Text(
            DateFormat.yMMMd("es-ES").format(tip.created),
          ),
        ),
        // image
        _buildImage(),
        //description
        Padding(
          padding: padding,
          child: Text(tip.description),
        ),
      ],
    );
  }

  Padding _buildImage() {
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
    return tip.tag == 'videos'
        ? FloatingActionButton.extended(
            icon: Icon(Icons.play_arrow),
            label: Text("Abrir Video"),
            onPressed: _launchURL,
          )
        : FloatingActionButton.extended(
            icon: Icon(Icons.link),
            label: Text("Abrir Enlace"),
            onPressed: _launchURL,
          );
  }

  _launchURL() async {
    if (await canLaunch(tip.link)) {
      await launch(tip.link);
    } else {
      throw 'Could not launch ${tip.link}';
    }
  }
}
