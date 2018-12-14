import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/cafe-cientifico/encuentro-card.dart';
import 'package:innovaciondocente_app/services/formacion-docente/cafe-cientifico/encuentro.dart';

class EncuentrosPage extends StatefulWidget {
  final Stream<List<Encuentro>> stream;

  const EncuentrosPage({Key key, this.stream}) : super(key: key);

  @override
  _EncuentrosPageState createState() => _EncuentrosPageState();
}

class _EncuentrosPageState extends State<EncuentrosPage> {
  List<Encuentro> _encuentros;
  StreamSubscription<List<Encuentro>> _subs;

  @override
  void initState() {
    super.initState();
    this._subs = widget.stream.listen((encuentros) {
      setState(() {
        this._encuentros = encuentros;
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
      appBar: AppBar(
        title: Text('Café Científico'),
        centerTitle: true,
        elevation: 0,
      ),
      body: this._encuentros == null
          ? Center(
              child: Text('Loading...'),
            )
          : _EncuentrosView(encuentros: _encuentros),
    );
  }
}

class _EncuentrosView extends StatelessWidget {
  const _EncuentrosView({
    Key key,
    @required List<Encuentro> encuentros,
  })  : encuentros = encuentros,
        super(key: key);

  final List<Encuentro> encuentros;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        /// background image
        _buildBackground(),
        _buildGradiente(),

        /// gallery
        Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Container(),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 7.5),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) =>
                      EncuentroCard(encuentro: encuentros[index]),
                  itemCount: encuentros.length,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Container _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: FadeInImage(
        image: NetworkImage(getLastEncuentro().img),
        placeholder: AssetImage('assets/images/default.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Container _buildGradiente() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.clamp,
          stops: [0, 0.4, 0.8],
          colors: <Color>[
            Colors.transparent,
            Colors.transparent,
            Colors.black,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Encuentro getLastEncuentro() {
    if (encuentros.length <= 0) return null;
    return encuentros[0];
  }
}
