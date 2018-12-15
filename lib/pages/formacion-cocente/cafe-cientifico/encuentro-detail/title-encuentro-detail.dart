import 'package:flutter/material.dart';

class TitleEncuentroDetail extends StatelessWidget {
  const TitleEncuentroDetail({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              name,
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          CloseButton(),
        ],
      ),
    );
  }
}
