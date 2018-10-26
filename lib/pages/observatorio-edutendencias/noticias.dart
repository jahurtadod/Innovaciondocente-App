import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/layouts/default.dart';

class Noticias extends StatefulWidget {
  @override
  _NoticiasState createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Container(
        child: Text("Hola noticias"),
      ),
    );
  }
}
