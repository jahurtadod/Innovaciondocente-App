import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/config/colors.dart';
import 'package:innovaciondocente_app/src/blocs/bloc-provider.bloc.dart';
import 'package:innovaciondocente_app/src/models/navigation.model.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder<List<IndevSection>>(
        stream: BlocProvider.of(context).blocs.navigation.outNavigation,
        builder: (BuildContext context, data) {
          List<IndevSection> sections = data.data;
          return ListView(
            children: sections
                .map((sec) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        sec.name == null
                            ? Container()
                            : _IndevTitleTile(
                                label: sec.name,
                              ),
                      ]
                        ..addAll(sec.routes.map((route) => _DrawerTile(
                              route: route,
                              onPressed: () {
                                BlocProvider.of(context)
                                    .blocs
                                    .navigation
                                    .uptateNavigation
                                    .add(route.route);
                              },
                            )))
                        ..addAll([
                          Divider(),
                        ]),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    Key key,
    @required this.route,
    @required this.onPressed,
  }) : super(key: key);

  final IndevRoute route;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0, bottom: 0, right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(50),
        ),
        child: Material(
          color: route.active ? IndevColors.blue : Colors.transparent,
          child: InkWell(
            onTap: () {
              if (!route.active) Navigator.pushNamed(context, route.route);
              onPressed();
            },
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Icon(
                    route.icon,
                    color: (route.active
                            ? Theme.of(context).accentIconTheme
                            : Theme.of(context).iconTheme)
                        .color,
                  ),
                ),
                Text(
                  route.name,
                  style: (route.active
                          ? Theme.of(context).accentTextTheme
                          : Theme.of(context).textTheme)
                      .button,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IndevTitleTile extends StatelessWidget {
  const _IndevTitleTile({
    Key key,
    @required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
      ),
    );
  }
}
