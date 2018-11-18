import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/classes/noticia.dart';

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
      backgroundColor: Theme.of(context).primaryColor,
      body: (this._noticias == null)
          ? Text("Loading")
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return (index % 9 == 0)
                    ? _BigCard(
                        noticia: _noticias[index],
                      )
                    : (index % 4 == 3)
                        ? _MediumCard(
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
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      Filters.date(noticia.created),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Text(Filters.slice(0, 75, noticia.description)),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 15.0),
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              image: DecorationImage(
                image: NetworkImage(noticia.img),
                fit: BoxFit.cover,
              ),
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

class _MediumCard extends StatelessWidget {
  final Noticia noticia;

  const _MediumCard({
    Key key,
    @required this.noticia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            Image.network(
              noticia.img,
              height: 150.0,
              width: double.infinity,
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
                    style: Theme.of(context).textTheme.title.copyWith(fontSize: 22.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      Filters.date(noticia.created),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Text(
                    Filters.slice(0, 200, noticia.description),
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ],
              ),
            ),
          ],
        ),
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
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 400.0,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  // background image
                  Image.network(
                    noticia.img,
                    width: double.infinity,
                    height: double.infinity,
                    filterQuality: FilterQuality.medium,
                    fit: BoxFit.cover,
                  ),
                  // gradien layer
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black,
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  // text layer
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 13.0),
                          child: Text(
                            noticia.name,
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(fontSize: 25.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 13.0),
              child: Text(
                Filters.date(noticia.created),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
