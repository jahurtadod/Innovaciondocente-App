import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/services/observatorio-edutendencias/noticias/noticia.dart';

class Noticias extends StatefulWidget {
  final Stream<List> stream;

  Noticias({this.stream});

  @override
  _NoticiasState createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  List<Noticia> _noticias;
  StreamSubscription<List<Noticia>> _subs;

  @override
  void initState() {
    super.initState();
    this._subs = widget.stream.listen((noticias) {
      setState(() {
        this._noticias = noticias;
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
    return Scaffold(
      backgroundColor: Colors.blue,
      body: (this._noticias == null)
          ? Text("Loading")
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return (index == 0)
                    ? _BigCard(
                        noticia: _noticias[index],
                      )
                    : _SmallCard(
                        noticia: _noticias[index],
                      );
              },
              itemCount: this._noticias.length,
            ),
    );
  }
}

class _SmallCard extends StatelessWidget {
  final Noticia noticia;

  const _SmallCard({
    Key key,
    @required this.noticia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      margin: EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 6,
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    noticia.name,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(noticia.description),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 15.0),
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(noticia.img),
                fit: BoxFit.cover,
              ),
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BigCard extends StatelessWidget {
  final Noticia noticia;

  const _BigCard({
    Key key,
    @required this.noticia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            Image.network(
              noticia.img,
              height: 400.0,
              filterQuality: FilterQuality.medium,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    noticia.name,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(noticia.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
