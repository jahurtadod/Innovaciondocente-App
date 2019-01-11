import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/resources/colors.dart';

class MainMenu extends StatelessWidget {
  MainMenu({
    Key key,
    @required String actualPath,
  })  : sections = MainMenu._genRoutes(actualPath),
        super(key: key);

  final List<_Section> sections;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 7.5),
          itemBuilder: _sectionBuilder,
          itemCount: sections.length,
        ),
      ),
    );
  }

  Widget _sectionBuilder(BuildContext context, int index) {
    _Section sec = this.sections[index];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            sec.name == null
                ? Container()
                : _IndevTitleTile(
                    label: sec.name,
                  ),
          ]..addAll(sec.routes.map((route) => _DrawerTile(
                route: route,
              )))),
    );
  }

  static List<_Section> _genRoutes(String actualPath) {
    return [
      _Section(
        routes: [
          _Route(
            name: 'Inicio',
            path: '/',
            actualPath: actualPath,
            icon: Icons.home,
            color: IndevColors.blue,
          ),
        ],
      ),
      // _Section(
      //   name: 'Innovación Docente',
      //   routes: [
      //     _Route(
      //       name: 'Buenas Prácticas',
      //       actualPath: actualPath,
      //       path: '/',
      //       icon: Icons.folder_special,
      //     ),
      //     _Route(
      //       name: 'Proyectos Actuales',
      //       actualPath: actualPath,
      //       path: '/',
      //       icon: Icons.folder_special,
      //     ),
      //   ],
      // ),
      _Section(
        name: 'Formación Docente',
        routes: [
          _Route(
            name: 'Progama de Formación',
            actualPath: actualPath,
            path: '/formacion-docente/programa-formacion',
            icon: Icons.school,
            color: IndevColors.formacion,
          ),
          _Route(
            name: 'Café Científico',
            actualPath: actualPath,
            path: '/formacion-docente/cafe-cientifico/encuentros',
            icon: Icons.chat,
            color: IndevColors.formacion,
          ),
        ],
      ),
      _Section(
        name: 'Observatorio EduTendencias',
        routes: [
          _Route(
            name: 'Noticias',
            actualPath: actualPath,
            path: '/observatorio-edutendencias/noticias',
            icon: Icons.new_releases,
            color: IndevColors.observatorio,
          ),
          _Route(
            name: 'Tips de Innovacion',
            actualPath: actualPath,
            path: '/observatorio-edutendencias/tips',
            icon: Icons.wb_incandescent,
            color: IndevColors.observatorio,
          ),
        ],
      ),
      // _Section(
      //   routes: [
      //     _Route(
      //       name: 'Información',
      //       actualPath: actualPath,
      //       path: '/',
      //       icon: Icons.info,
      //     ),
      //   ],
      // )
    ];
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    Key key,
    @required this.route,
  }) : super(key: key);

  final _Route route;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0, bottom: 0, right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(50),
        ),
        child: Material(
          color: route.active ? route.color : Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              if (!route.active) Navigator.pushNamed(context, route.path);
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

class _Section {
  final String name;
  final List<_Route> routes;

  _Section({
    this.name,
    this.routes,
  });
}

class _Route {
  final String name;
  final String path;
  final bool active;
  final IconData icon;
  final Color color;

  _Route({
    this.name,
    this.path,
    String actualPath,
    this.icon,
    this.color,
  }) : active = actualPath == path;
}
