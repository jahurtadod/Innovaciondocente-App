import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/layouts/default.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Container(
        child: Center(
          child: Text("Home"),
        ),
      ),
    );
  }
}
