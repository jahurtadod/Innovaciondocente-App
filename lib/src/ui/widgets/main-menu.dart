import 'dart:math';
import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/config/colors.dart';
import 'package:innovaciondocente_app/src/models/navigation.model.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({
    Key key,
  }) : super(key: key);

  @override
  MainMenuState createState() {
    return MainMenuState();
  }
}

class MainMenuState extends State<MainMenu> {
  List<IndevSection> sections;

  @override
  void initState() {
    super.initState();
    createRoutes('/');
  }

// TODO: move to bloc pattern
  void createRoutes(String path) {
    this.sections = [
      IndevSection(
        routes: [
          IndevRoute(
            name: 'Inicio',
            route: '/',
            path: path,
            icon: Icons.home,
          ),
        ],
      ),
      IndevSection(
        name: 'Innovación Docente',
        routes: [
          IndevRoute(
            name: 'Buenas Prácticas',
            path: path,
            route: '/',
            icon: Icons.folder_special,
          ),
          IndevRoute(
            name: 'Proyectos Actuales',
            path: path,
            route: '/',
            icon: Icons.folder_special,
          ),
        ],
      ),
      IndevSection(
        name: 'Formación Docente',
        routes: [
          IndevRoute(
            name: 'Progama de Formación',
            path: path,
            route: '/formacion-docente/programa-formacion',
            icon: Icons.school,
          ),
          IndevRoute(
            name: 'Café Científico',
            path: path,
            route: '/formacion-docente/cafe-cientifico/encuentros',
            icon: Icons.chat,
          ),
        ],
      ),
      IndevSection(
        name: 'Observatorio EduTendencias',
        routes: [
          IndevRoute(
            name: 'Noticias',
            path: path,
            route: '/observatorio-edutendencias/noticias',
            icon: Icons.new_releases,
          ),
          IndevRoute(
            name: 'Tips de Innovacion',
            path: path,
            route: '/observatorio-edutendencias/tips',
            icon: Icons.wb_incandescent,
          ),
        ],
      ),
      IndevSection(
        routes: [
          IndevRoute(
            name: 'Información',
            path: path,
            route: '/observatorio-edutendencias/noticias',
            icon: Icons.info,
          ),
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
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
                    ..addAll(sec.routes.map(
                      (route) => _DrawerTile(
                          route: route,
                          onPressed: () {
                            setState(() {
                              createRoutes(route.route);
                            });
                          }),
                    ))
                    ..addAll([
                      Divider(),
                    ]),
                ))
            .toList(),
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
