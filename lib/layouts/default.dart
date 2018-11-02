import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget body;
  final String title;

  DefaultLayout({
    @required this.body,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // top
      appBar: AppBar(
        title: Text(title),
      ),
      body: this.body,
    );
  }
}
