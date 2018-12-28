import 'dart:math';

import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/database/database.dart';
import 'package:innovaciondocente_app/src/resources/colors.dart';
import 'package:innovaciondocente_app/src/resources/filters.dart';

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
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _Section(
                label: "Próximos Cursos",
                stream: DBProvider.of(context).dbData.proximosCursosStream,
                errorMessage: 'No se encontraron cursos Próximos',
                color: IndevColors.formacion,
              ),
              _Section(
                label: "Ultimos InnovaTic's",
                stream: DBProvider.of(context).dbData.innovaTicsStream,
                errorMessage: "No se encontraron InnovaTic's",
                color: IndevColors.formacion,
              ),
              _Section(
                label: "Próximos Encuentros",
                stream: DBProvider.of(context).dbData.proximosEncuentrosStream,
                errorMessage: "No hay encuentros Próximos",
                color: IndevColors.formacion,
              ),
              _Section(
                label: "Noticias del Mes",
                stream: DBProvider.of(context).dbData.ultimasNoticiasStream,
                errorMessage: "No se encontraron Noticas",
                color: IndevColors.observatorio,
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String label;
  final String errorMessage;
  final Stream stream;
  final Color color;

  const _Section({
    Key key,
    this.label,
    this.stream,
    this.errorMessage,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// section header
        Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 7.5),
          child: Text(
            label,
            style: Theme.of(context).textTheme.overline.copyWith(color: color),
          ),
        ),

        /// section list
        StreamBuilder(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot == null || snapshot.data == null)
                return Center(child: CircularProgressIndicator(strokeWidth: 2));
              List data = snapshot.data as List;
              if (data.length == 0) return Center(child: Text(errorMessage));
              return Column(
                children: (snapshot.data as List)
                    .map((d) => _NotificationTile(
                          data: d,
                          color: color,
                        ))
                    .toList(),
              );
            }),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final dynamic data;
  final Color color;

  const _NotificationTile({
    Key key,
    this.data,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.radio_button_checked,
                size: 15,
                color: color,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.name,
                      style: Theme.of(context).textTheme.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      Filters.date(data.date),
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
