import 'dart:async';

import 'package:flutter/material.dart';

import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion-database.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/tips-innovacion.dart';

class TipsInnovacionPage extends StatefulWidget {
  final Database database;
  final Stream<List> stream;
  String tag = '';

  TipsInnovacionPage({this.database, this.stream});

  @override
  _TipsInnovacionPageState createState() => _TipsInnovacionPageState();
}

class _TipsInnovacionPageState extends State<TipsInnovacionPage> {
  List<TipInnovacion> _tips;
  StreamSubscription _subs;

  @override
  void initState() {
    super.initState();
    this._subs = widget.stream.listen((tips) {
      setState(() {
        this._tips = tips;
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
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Tips de Innovación"),
            ),
            floating: true,
            snap: true,
          ),
          SliverList(delegate: SliverChildListDelegate(this._buildListTips()))
        ],
      ),
    );
  }

  List<Widget> _buildListTips() {
    // component is loading
    if (this._tips == null)
      return [
        Text("Loading"),
      ];

    // list of new is empty
    if (this._tips.length == 0)
      return [
        Icon(
          Icons.block,
          size: 40.0,
        ),
        Text(
          "There are no items to show",
          style: Theme.of(context).textTheme.subhead,
        ),
      ];

    // list has items return list view
    List<Widget> res = [];
    // add otions
    res.add(_buildFilters());

    // add card items
    for (TipInnovacion tip in this._tips) {
      if (tip.tag == widget.tag || widget.tag == '') res.add(this._buidItemCard(tip));
    }
    return res;
  }

  Container _buildFilters() {
    return Container(
      height: 110.0,
      child: ListView(
        children: <Widget>[
          _buildButtonQuery(
            image:
                'https://firebasestorage.googleapis.com/v0/b/innovaciondocente-utpl.appspot.com/o/observatorio-edutendencias%2Fobsevatorio%2Fpod.jpg?alt=media&token=d791889c-15cc-403c-9cf2-a5dc74f20505',
            title: 'TODOS',
            tag: '',
          ),
          _buildButtonQuery(
            image:
                'https://firebasestorage.googleapis.com/v0/b/innovaciondocente-utpl.appspot.com/o/observatorio-edutendencias%2Fobsevatorio%2Ffun.jpg?alt=media&token=36c1f88d-e4fa-4636-a562-a32a85e1c9c9',
            title: 'AULA DIVERTIDA',
            tag: 'aula-divertida',
          ),
          _buildButtonQuery(
            image:
                "https://firebasestorage.googleapis.com/v0/b/innovaciondocente-utpl.appspot.com/o/observatorio-edutendencias%2Fobsevatorio%2Fdocfut.jpg?alt=media&token=5733d1a3-1249-40f5-a705-970c4d1df82f",
            title: 'DOCENTES DEL FUTURO',
            tag: 'docentes-futuro',
          ),
          _buildButtonQuery(
            image:
                'https://firebasestorage.googleapis.com/v0/b/innovaciondocente-utpl.appspot.com/o/observatorio-edutendencias%2Fobsevatorio%2Fvideo.jpg?alt=media&token=00090cf4-7470-4c49-8fb9-99c95cae2ade',
            title: 'VIDEOS',
            tag: 'videos',
          ),
        ],
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  StatelessWidget _buildButtonQuery({
    @required String tag,
    @required String title,
    @required String image,
  }) {
    return (tag == this.widget.tag)
        ? Container()
        : _ButtomQuery(
            image: image,
            onTap: () {
              setState(() {
                this.widget.tag = tag;
              });
            },
            title: title,
          );
  }

  Widget _buidItemCard(TipInnovacion tip) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(tip.img),
          Text(
            tip.name,
            style: Theme.of(context).textTheme.title,
          ),
          Text(tip.description),
        ],
      ),
    );
  }
}

class _ButtomQuery extends StatelessWidget {
  const _ButtomQuery({
    Key key,
    @required this.title,
    @required this.image,
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final String image;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 5.0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
        ),
        child: Center(
          child: Text(
            this.title,
            style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            image: NetworkImage(this.image),
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor,
              BlendMode.softLight,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
