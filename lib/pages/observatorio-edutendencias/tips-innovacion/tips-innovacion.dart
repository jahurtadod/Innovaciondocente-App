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
    List<TipInnovacion> tips = (this._tips == null)
        ? null
        : this._tips.where((tip) => tip.tag == this._tag || this._tag == 'todos').toList();

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
                  subtitle: Text(Filters.date(tip.created)),
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
