import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/config/colors.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 7.5),
          children: <Widget>[
            DrawerTile(
              label: 'Inicio',
              icon: Icons.home,
              active: true,
              goto: '/',
            ),
            Divider(),
            DrawerLabelTile(
              label: 'Innovación Docente',
            ),
            DrawerTile(
              icon: Icons.folder_special,
              label: 'Buenas Prácticas',
              goto: '/',
            ),
            DrawerTile(
              icon: Icons.explore,
              label: 'Proyectos Actuales',
              goto: '/',
            ),
            Divider(),
            DrawerLabelTile(
              label: 'Formación Docente',
            ),
            DrawerTile(
              icon: Icons.school,
              label: 'Progama de Formación',
              goto: '/formacion-docente/programa-formacion',
            ),
            DrawerTile(
              icon: Icons.chat,
              label: 'Café Científico',
              goto: '/formacion-docente/cafe-cientifico/encuentros',
            ),
            Divider(),
            DrawerLabelTile(
              label: 'Observatorio EduTendencias',
            ),
            DrawerTile(
              icon: Icons.new_releases,
              label: 'Noticias',
              goto: '/observatorio-edutendencias/noticias',
            ),
            DrawerTile(
              icon: Icons.wb_incandescent,
              label: 'Tips de Innovacion',
              goto: '/observatorio-edutendencias/tips',
            ),
            Divider(),
            DrawerTile(
              icon: Icons.info,
              label: 'Información',
              goto: '/',
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerLabelTile extends StatelessWidget {
  const DrawerLabelTile({
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

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    Key key,
    this.active = false,
    @required this.label,
    @required this.goto,
    @required this.icon,
  }) : super(key: key);

  final bool active;
  final String label;
  final String goto;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0, bottom: 0, right: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(50),
        ),
        child: Material(
          color: active ? IndevColors.blue : Colors.transparent,
          child: InkWell(
            onTap: () {
              if (!active) Navigator.pushNamed(context, goto);
            },
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Icon(
                    icon,
                    color:
                        (active ? Theme.of(context).accentIconTheme : Theme.of(context).iconTheme)
                            .color,
                  ),
                ),
                Text(
                  label,
                  style: (active ? Theme.of(context).accentTextTheme : Theme.of(context).textTheme)
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
