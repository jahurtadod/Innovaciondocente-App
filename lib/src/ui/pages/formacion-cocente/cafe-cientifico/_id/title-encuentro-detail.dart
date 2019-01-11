import 'package:flutter/material.dart';

class TitleEncuentroDetail extends StatelessWidget {
  const TitleEncuentroDetail({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            name,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        CloseButton(),
      ],
    );
  }
}
