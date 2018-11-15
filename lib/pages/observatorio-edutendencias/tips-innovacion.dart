import 'dart:async';
import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/tip-detail.dart';

import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion-database.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TipsInnovacionPage extends StatefulWidget {
  final Database database;
  final Stream<List> stream;

  TipsInnovacionPage({this.database, this.stream});

  @override
  _TipsInnovacionPageState createState() => _TipsInnovacionPageState();
}

class _TipsInnovacionPageState extends State<TipsInnovacionPage>
    with SingleTickerProviderStateMixin {
  List<TipInnovacion> _tips;
  StreamSubscription<List<TipInnovacion>> _subs;
  String _tag = "";

  @override
  void initState() {
    super.initState();
    this._subs = widget.stream.listen((tips) {
      setState(() {
        this._tips = tips;
        print("setting state");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    this._subs.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: add filter
    List<TipInnovacion> tips =
        (this._tips == null) ? null : this._tips.where((tip) => true).toList();

    return Scaffold(
      body: (this._tips == null)
          ? Text("Loading")
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _TipCard(
                  tip: tips[index],
                );
              },
              itemCount: tips.length,
            ),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.filter_list),
      label: Text("Seleccionar Categoría"),
      onPressed: () {
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/innovaciondocente-utpl.appspot.com/o/observatorio-edutendencias%2Fobsevatorio%2Ffun.jpg?alt=media&token=36c1f88d-e4fa-4636-a562-a32a85e1c9c9',
                      ),
                    ),
                    title: Text('AULA DIVERTIDA'),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/innovaciondocente-utpl.appspot.com/o/observatorio-edutendencias%2Fobsevatorio%2Fdocfut.jpg?alt=media&token=5733d1a3-1249-40f5-a705-970c4d1df82f',
                      ),
                    ),
                    title: Text('DOCENTES DEL FUTURO'),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/innovaciondocente-utpl.appspot.com/o/observatorio-edutendencias%2Fobsevatorio%2Fvideo.jpg?alt=media&token=00090cf4-7470-4c49-8fb9-99c95cae2ade',
                      ),
                    ),
                    title: Text('VIDEOS'),
                    onTap: () => {},
                  ),
                ],
              );
            });
      },
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
            tooltip: "Abrir todos los Tips",
            icon: Icon(Icons.launch),
            color: Colors.white,
            onPressed: _launchURL,
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    String url =
        "https://innovaciondocente-utpl.firebaseapp.com/observatorio-edutendencias/tips-innovacion";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch ${url}';
    }
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard({
    Key key,
    @required this.tip,
  }) : super(key: key);

  final TipInnovacion tip;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return TipDetail(
                  tip: tip,
                );
              }));
            },
            child: Column(
              children: <Widget>[
                // image - header
                _buildCardHeader(context),
                // title
                ListTile(
                  title: Text(tip.name),
                  subtitle: Text(
                    DateFormat.yMMMMEEEEd("es_ES").format(tip.created),
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Stack _buildCardHeader(BuildContext context) {
    return Stack(
      children: <Widget>[
        // background imagge
        Container(
          height: 170.0,
          width: double.infinity,
          child: Image.network(
            tip.img,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
          ),
          color: Theme.of(context).primaryColor,
        ),

        // front face text
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 20.0,
            ),
            child: Text(
              tip.tag.toUpperCase(),
              style: Theme.of(context).accentTextTheme.caption,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
