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
              Navigator.pushNamed(context, '/noticas');
            },
          ),
        ],
      ),
    );
  }
}
