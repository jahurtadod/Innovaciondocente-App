import 'package:flutter/material.dart';

class Home extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        children: <Widget>[
          Text("Hello u"),
          RaisedButton(
            child: Text("go to news"),
            onPressed: () {
              Navigator.pushNamed(context, '/observatorio-edutendencias/noticias');
            },
          ),
          RaisedButton(
            child: Text("go to tips"),
            onPressed: () {
              Navigator.pushNamed(context, '/observatorio-edutendencias/tips');
            },
          ),
          RaisedButton(
            child: Text("go to encuentros Cursos"),
            onPressed: () {
              Navigator.pushNamed(context, '/formacion-docente/programa-formacion');
            },
          ),
          RaisedButton(
            child: Text("go to encuentros cafe cientifico"),
            onPressed: () {
              Navigator.pushNamed(context, '/formacion-docente/cafe-cientifico/encuentros');
            },
          ),
          RaisedButton(
            child: Text("go to inicio"),
            onPressed: () {
              Navigator.pushNamed(context, '/start');
            },
          ),
        ],
      ),
    );
  }
}
