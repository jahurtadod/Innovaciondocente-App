import 'dart:async';

import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/services/formacion-docente/cafe-cientifico/encuentro.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/cafe-cientifico/home/encuentros-view.dart';
import 'package:innovaciondocente_app/src/ui/widgets/loader.dart';
import 'package:innovaciondocente_app/src/ui/widgets/main-menu.dart';

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
      drawer: MainMenu(
        actualPath: '/formacion-docente/cafe-cientifico/encuentros',
      ),
      appBar: AppBar(
        title: Text('Café Científico'),
      ),
      body: this._encuentros == null ? Loader() : EncuentrosView(encuentros: _encuentros),
    );
  }
}
