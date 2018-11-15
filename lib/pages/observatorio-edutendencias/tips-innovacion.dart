import 'dart:async';
import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/tip-detail.dart';

import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion-database.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion.dart';

class TipsInnovacionPage extends StatefulWidget {
  final Database database;
  final Stream<List> stream;

  TipsInnovacionPage({this.database, this.stream});

  @override
  _TipsInnovacionPageState createState() => _TipsInnovacionPageState();
}

class _TipsInnovacionPageState extends State<TipsInnovacionPage>
    with SingleTickerProviderStateMixin {
  List<TipInnovacion> _aulaDivertida = [], _docenteFuturo = [], _videos = [];
  StreamSubscription _subs;
  TabController _tabController;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    this._tabController = TabController(length: 3, vsync: this);
    this._subs = widget.stream.listen((tips) {
      setState(() {
        this._loaded = true;
        // turn data into slitted lists
        for (TipInnovacion tip in tips)
          if (tip.tag == "videos")
            this._videos.add(tip);
          else if (tip.tag == "aula-divertida")
            this._aulaDivertida.add(tip);
          else if (tip.tag == "docentes-futuro") this._docenteFuturo.add(tip);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    this._subs.cancel();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tips de Innovación'),
      ),
      body: !_loaded ? Text("Loading") : _buildTabBarView(),
      bottomNavigationBar: _buildTabBar(),
    );
  }

  TabBarView _buildTabBarView() {
    return TabBarView(
      controller: this._tabController,
      children: [
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return _TipCard(
              tip: this._aulaDivertida[index],
            );
          },
          itemCount: this._aulaDivertida.length,
        ),
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return _TipCard(
              tip: this._docenteFuturo[index],
            );
          },
          itemCount: this._docenteFuturo.length,
        ),
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return _TipCard(
              tip: this._videos[index],
            );
          },
          itemCount: this._videos.length,
        ),
      ],
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      indicatorColor: Theme.of(context).primaryColor,
      labelPadding: EdgeInsets.all(0.0),
      controller: this._tabController,
      isScrollable: true,
      tabs: [
        QueryBTN(
          image:
              'https://firebasestorage.googleapis.com/v0/b/innovaciondocente-utpl.appspot.com/o/observatorio-edutendencias%2Fobsevatorio%2Ffun.jpg?alt=media&token=36c1f88d-e4fa-4636-a562-a32a85e1c9c9',
          title: 'AULA DIVERTIDA',
        ),
        QueryBTN(
          image:
              "https://firebasestorage.googleapis.com/v0/b/innovaciondocente-utpl.appspot.com/o/observatorio-edutendencias%2Fobsevatorio%2Fdocfut.jpg?alt=media&token=5733d1a3-1249-40f5-a705-970c4d1df82f",
          title: 'DOCENTES DEL FUTURO',
        ),
        QueryBTN(
          image:
              'https://firebasestorage.googleapis.com/v0/b/innovaciondocente-utpl.appspot.com/o/observatorio-edutendencias%2Fobsevatorio%2Fvideo.jpg?alt=media&token=00090cf4-7470-4c49-8fb9-99c95cae2ade',
          title: 'VIDEOS',
        ),
      ],
    );
  }
}

class QueryBTN extends StatelessWidget {
  const QueryBTN({
    Key key,
    @required this.title,
    @required this.image,
  }) : super(key: key);

  final String title, image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 4.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        image: DecorationImage(
          image: NetworkImage(image),
          colorFilter: ColorFilter.mode(
            Theme.of(context).primaryColor,
            BlendMode.softLight,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
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
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
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
                  subtitle: Text(tip.created.toString()),
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
              style: Theme.of(context).primaryTextTheme.caption,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
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
