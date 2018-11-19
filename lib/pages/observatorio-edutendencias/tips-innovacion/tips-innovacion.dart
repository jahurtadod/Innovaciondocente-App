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
                      (index % 6 == 0)
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
}

class _SmallCard {}
