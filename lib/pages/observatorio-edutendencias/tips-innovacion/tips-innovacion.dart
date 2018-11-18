import 'dart:async';
import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/classes/tips-innovacion.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/tips-innovacion/tip-detail.dart';

class TipsInnovacionPage extends StatefulWidget {
  final Stream<List> stream;

  TipsInnovacionPage({this.stream});

  @override
  _TipsInnovacionPageState createState() => _TipsInnovacionPageState();
}

class _TipsInnovacionPageState extends State<TipsInnovacionPage> {
  List<TipInnovacion> _tips;
  StreamSubscription<List<TipInnovacion>> _subs;
  String _tag = 'todos';

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
    // filter tips by tag
    List<TipInnovacion> tips = (this._tips == null)
        ? null
        : this._tips.where((tip) => tip.tag == this._tag || this._tag == 'todos').toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tips Innovación'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.open_in_new),
            onPressed: () {},
          ),
        ],
      ),

      // main content
      body: Container(
        color: Theme.of(context).primaryColor,
        child: (this._tips == null)
            ? Text("Loading")
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return (index % 9 == 0)
                      ? _BigCard(
                          tip: tips[index],
                        )
                      : (index % 4 == 3)
                          ? _MediumCard(
                              tip: tips[index],
                            )
                          : _SmallCard(
                              tip: tips[index],
                            );
                },
                itemCount: tips.length,
              ),
      ),

      // Bottom page config
      // floatingActionButton: _buildFloatingActionButton(context),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: _buildBottomAppBar(context),
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
                  title: Text("Categorias"),
                  enabled: false,
                ),
                _listTile(
                  context: context,
                  text: 'Todos',
                  tag: 'todos',
                ),
                _listTile(
                  context: context,
                  text: 'Aula Divertida',
                  tag: 'aula-divertida',
                ),
                _listTile(
                  context: context,
                  text: 'Docentes del Futuro',
                  tag: 'docentes-futuro',
                ),
                _listTile(
                  context: context,
                  text: 'Videos',
                  tag: 'videos',
                ),
                // other options
                Divider(),
                ListTile(
                  leading: Icon(Icons.launch),
                  title: Text("Ver todos los Tips"),
                  onTap: _gotoTipsWeb,
                ),
              ],
            );
          },
        );
      },
    );
  }

  ListTile _listTile({
    @required BuildContext context,
    @required String text,
    @required String tag,
  }) {
    Function fn = () {
      setState(() {
        this._tag = tag;
      });
      Navigator.pop(context);
    };
    return this._tag.contains(tag)
        ? ListTile(
            selected: true,
            trailing: Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: fn,
          )
        : ListTile(
            title: Text(text),
            onTap: fn,
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
            onPressed: _gotoTipsWeb,
          ),
        ],
      ),
    );
  }

  _gotoTipsWeb() {
    Filters.launchURL(
        'https://innovaciondocente-utpl.firebaseapp.com/observatorio-edutendencias/tips-innovacion');
  }
}

class _SmallCard extends StatelessWidget {
  final TipInnovacion tip;

  const _SmallCard({
    Key key,
    @required this.tip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MaterialCard(
      tip: tip,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // right side, text, details
          Expanded(
            child: _CardDetails(tip: tip),
          ),

          // Img
          Container(
            margin: const EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 15.0),
            height: 110.0,
            width: 110.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              image: DecorationImage(
                image: NetworkImage(tip.img),
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
  final TipInnovacion tip;

  const _MediumCard({
    Key key,
    @required this.tip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MaterialCard(
      tip: tip,
      child: Column(
        children: <Widget>[
          // top img
          Image.network(
            tip.img,
            height: 150.0,
            width: double.infinity,
            filterQuality: FilterQuality.medium,
            fit: BoxFit.cover,
          ),

          // text and content
          _CardDetails(tip: tip),
        ],
      ),
    );
  }
}

class _BigCard extends StatelessWidget {
  final TipInnovacion tip;

  const _BigCard({
    Key key,
    @required this.tip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MaterialCard(
      tip: tip,
      child: Column(
        children: <Widget>[
          Container(
            height: 350.0,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                // background image
                Image.network(
                  tip.img,
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
                          tip.name,
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(fontSize: 22.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 13.0),
            child: Text(
              Filters.date(tip.created),
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }
}

class _MaterialCard extends StatelessWidget {
  final Widget child;
  final TipInnovacion tip;

  _MaterialCard({
    @required this.child,
    @required this.tip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return TipDetail(
                  tip: tip,
                );
              }));
            },
            child: this.child,
          ),
        ),
      ),
    );
  }
}

class _CardDetails extends StatelessWidget {
  const _CardDetails({
    Key key,
    @required this.tip,
  }) : super(key: key);

  final TipInnovacion tip;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              Filters.slice(0, 45, tip.name),
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(Filters.slice(0, 75, tip.description)),
          ),
          Text(
            Filters.date(tip.created),
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
