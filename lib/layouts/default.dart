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
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              padding: EdgeInsets.all(0.0),
              onPressed: () {},
              color: Colors.white,
            )
          ],
        ),
        notchMargin: 10.0,
        color: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.computer),
        label: Text("Do something"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: this.body,
    );
  }
}
