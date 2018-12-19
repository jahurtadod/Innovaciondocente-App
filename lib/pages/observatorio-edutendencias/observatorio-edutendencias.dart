import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/config/colors.dart';

class ObservatorioEdutendenciasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formación Docente'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Material(
              color: IndevColors.observatorio,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/observatorio-edutendencias/tips');
                },
                child: Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Tips de Innovacion',
                        style: Theme.of(context).accentTextTheme.display1,
                      ),
                      SizedBox(height: 15),
                      Text(
                        ' - AULA DIVERTIDA\n - DOCENTES DEL FUTURO\n - VIDEOS',
                        style: Theme.of(context).accentTextTheme.body1,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Text(
                            'Ver Tips',
                            style: Theme.of(context).accentTextTheme.overline,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            size: 18,
                            color: Theme.of(context).accentIconTheme.color,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/observatorio-edutendencias/noticias');
                },
                child: Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Noticias',
                        style: Theme.of(context).textTheme.display1,
                      ),
                      // SizedBox(height: 15),
                      // Text(
                      //   'Encuentro Café Científico es un evento en el que expertos y profesionales en diferentes campos, dialogan y problematizan sobre un tema actual de una forma diferente e informal. Su finalidad de escuchar opiniones diversas y realizar algunos postulados que contribuyan al trabajo posterior y que ayuden a fomentar inquietudes que despiertan una entretenida discusión.',
                      //   maxLines: 5,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Text('Ver Noticias'),
                          Icon(
                            Icons.keyboard_arrow_right,
                            size: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
