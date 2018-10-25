import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;

  DefaultLayout({
    @required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              child: Text("Hola"),
              textColor: Colors.grey,
              padding: EdgeInsets.all(0.0),
              onPressed: () {},
            ),
            FlatButton(
              child: Text("Hola"),
              textColor: Colors.white,
              padding: EdgeInsets.all(0.0),
              onPressed: () {},
            )
          ],
        ),
        notchMargin: 10.0,
        color: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: this.body,
    );
  }
}
