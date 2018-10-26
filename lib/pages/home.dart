import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/layouts/default.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: <Widget>[
          Text("Hello u"),
          RaisedButton(
            child: Text("go to news"),
            onPressed: () {
              Navigator.pushNamed(context, '/noticas');
            },
          ),
        ],
      ),
    );
  }
}
