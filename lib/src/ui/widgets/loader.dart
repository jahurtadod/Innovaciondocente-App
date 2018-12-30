import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircularProgressIndicator(strokeWidth: 2),
    ));
  }
}
