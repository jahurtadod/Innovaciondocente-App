import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/cafe-cientifico/encuentros/encuentros-view.dart';
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
        backgroundColor: Colors.transparent,
      ),
      body: this._encuentros == null
          ? Center(
              child: Text('Loading...'),
            )
          : EncuentrosView(encuentros: _encuentros),
    );
  }
}
