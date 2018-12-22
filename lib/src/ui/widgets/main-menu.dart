import 'dart:math';
import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/config/colors.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
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
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            actions: <Widget>[
              CloseButton(),
            ],
          ),
          _buildSliverMenu(),
        ],
      ),
    );
  }

  SliverList _buildSliverMenu() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _DrawerTile(
            label: 'Inicio',
            icon: Icons.home,
            active: true,
            goto: '/',
          ),
          Divider(),
          _IndevTitleTile(
            label: 'Innovación Docente',
          ),
          _DrawerTile(
            icon: Icons.folder_special,
            label: 'Buenas Prácticas',
            goto: '/',
          ),
          Divider(),
          _IndevTitleTile(
            label: 'Formación Docente',
          ),
          _DrawerTile(
            icon: Icons.school,
            label: 'Progama de Formación',
            goto: '/formacion-docente/programa-formacion',
          ),
          _DrawerTile(
            icon: Icons.chat,
            label: 'Café Científico',
            goto: '/formacion-docente/cafe-cientifico/encuentros',
          ),
          Divider(),
          _IndevTitleTile(
            label: 'Observatorio EduTendencias',
          ),
          _DrawerTile(
            icon: Icons.new_releases,
            label: 'Noticias',
            goto: '/observatorio-edutendencias/noticias',
          ),
          _DrawerTile(
            icon: Icons.wb_incandescent,
            label: 'Tips de Innovacion',
            goto: '/observatorio-edutendencias/tips',
          ),
          Divider(),
          _DrawerTile(
            icon: Icons.info,
            label: 'Información',
            goto: '/',
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
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
