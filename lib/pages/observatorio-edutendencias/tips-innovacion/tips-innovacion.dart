import 'dart:async';
import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/classes/tips-innovacion.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/tips-innovacion/MediumCard.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/tips-innovacion/SmallCard.dart';
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
          _buildOptions(context),
        ],
      ),

      // main content
      body: Container(
        child: (this._tips == null)
            ? Text("Loading")
            : ListView.builder(
                itemCount: tips.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      (index % 4 == 0)
                          ? MediumCard(
                              tip: tips[index],
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (BuildContext context) {
                                  return TipDetail(
                                    tip: tips[index],
                                  );
                                }));
                              },
                            )
                          : SmallCard(
                              tip: tips[index],
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (BuildContext context) {
                                  return TipDetail(
                                    tip: tips[index],
                                  );
                                }));
                              },
                            ),
                      Divider(),
                    ],
                  );
                },
              ),
      ),
    );
  }

  IconButton _buildOptions(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  onTap: () {
                    Filters.launchURL(
                        'https://innovaciondocente-utpl.firebaseapp.com/observatorio-edutendencias/tips-innovacion');
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _listTile({
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
        // this is selected tile
        ? _ListTile(
            text,
            active: true,
          )
        // normal tile
        : Material(
            child: InkWell(
              onTap: fn,
              child: _ListTile(text),
            ),
          );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile(
    this.text, {
    Key key,
    this.active: false,
  }) : super(key: key);

  final bool active;
  final String text;

  @override
  Widget build(BuildContext context) {
    // filled tile
    if (active)
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(3.0),
            bottomRight: Radius.circular(3.0),
          ),
        ),
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        padding: EdgeInsets.all(10.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.overline.copyWith(
                color: Colors.white,
                fontSize: 15.0,
              ),
        ),
      );

    // build outline tile
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
        // borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
      width: double.infinity,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.overline.copyWith(
              fontSize: 15.0,
            ),
      ),
    );
  }
}
