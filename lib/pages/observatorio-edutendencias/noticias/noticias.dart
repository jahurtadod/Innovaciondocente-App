import 'package:flutter/material.dart';

class Noticias extends StatefulWidget {
  @override
  _NoticiasState createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: ListView(
        children: <Widget>[
          new _BigCard(),
          new _SmallCard(),
          new _SmallCard(),
          new _SmallCard(),
          new _BigCard(),
          new _SmallCard(),
          new _SmallCard(),
          new _SmallCard(),
          new _BigCard(),
          new _SmallCard(),
          new _SmallCard(),
          new _SmallCard(),
          new _SmallCard(),
        ],
      ),
    );
  }
}

class _SmallCard extends StatelessWidget {
  const _SmallCard({
    Key key,
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
        children: <Widget>[
          Flexible(
            flex: 6,
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'INNOVACIÓN MATEMÁTICA',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                      'La Universidad Técnica Particular de Loja dentro de sus actividades académicas en vinculación y con el fin ...'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/innovaciondocente-utpl.appspot.com/o/observatorio-edutendencias%2Fnoticias%2Finnovacion-matematica%2FMatematicasA.png?alt=media&amp;token=46d41388-d71e-4555-b55c-0a0c4aa554bd',
                fit: BoxFit.cover,
                height: 100.0,
                width: 100.0,
                filterQuality: FilterQuality.low,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BigCard extends StatelessWidget {
  const _BigCard({
    Key key,
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
              'https://firebasestorage.googleapis.com/v0/b/innovaciondocente-utpl.appspot.com/o/observatorio-edutendencias%2Fnoticias%2Finnovacion-matematica%2FMatematicasA.png?alt=media&amp;token=46d41388-d71e-4555-b55c-0a0c4aa554bd',
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
                    'INNOVACIÓN MATEMÁTICA',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                      'La Universidad Técnica Particular de Loja dentro de sus actividades académicas en vinculación y con el fin nexos con la Educación Secundaria emprendió el curso denominado “Estrategias Institucionales para el de Enseñanza de la Matemática...'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
