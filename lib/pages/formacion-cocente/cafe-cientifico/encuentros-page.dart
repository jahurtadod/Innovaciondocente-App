import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/services/formacion-docente/cafe-cientifico/encuentro.dart';

class EncuentrosPage extends StatefulWidget {
  final Stream<List> stream;

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
        print(encuentros);
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
      body: ListView(
        children: this
            ._encuentros
            .map((val) => Container(
                  child: Text(val.name),
                ))
            .toList(),
      ),
    );
  }
}
