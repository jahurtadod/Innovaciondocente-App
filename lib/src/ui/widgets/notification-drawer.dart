import 'dart:math';

import 'package:flutter/material.dart';

class NotificationDrawer extends StatelessWidget {
  const NotificationDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = min(size.height, size.width);
    return Container(
      width: width,
      height: double.infinity,
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            actions: [
              CloseButton(),
            ],
            titleSpacing: 15,
            title: Text('Notificaciones'),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _HastagTile(label: "Ultimo InnovaTip"),
              _HastagTile(label: "Siguiente Cursos"),
              _HastagTile(label: "Siguiente Encuentro"),
            ]),
          )
        ],
      ),
    );
  }
}

class _HastagTile extends StatelessWidget {
  const _HastagTile({
    Key key,
    @required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        label,
        style: Theme.of(context).textTheme.overline,
      ),
    );
  }
}
