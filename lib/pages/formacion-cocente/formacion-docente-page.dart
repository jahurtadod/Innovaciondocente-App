import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/config/colors.dart';

class FormacionDocentePage extends StatelessWidget {
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
              color: IndevColors.formacion,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/formacion-docente/programa-formacion');
                },
                child: Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Progama de Formación',
                        style: Theme.of(context).accentTextTheme.display1,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'El Programa de Formación Docente de la universidad está orientado de forma prioritaria a facilitar y apoyar a nuestros docentes al desarrollo de sus necesidades de tipo formativo, dotándoles de las estrategias y recursos necesarios para desarrollar una serie de nuevas competencias profesionales. Por este motivo es preciso reflexionar sobre las nuevas exigencias profesionales y apoyar el desarrollo de dichas competencias desde la formación del profesorado y desde el enfoque de nuestra universidad.',
                        style: Theme.of(context).accentTextTheme.body1,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Text(
                            'Ver Cursos',
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
                  Navigator.pushNamed(context, '/formacion-docente/cafe-cientifico/encuentros');
                },
                child: Container(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Café Científico',
                        style: Theme.of(context).textTheme.display1,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Encuentro Café Científico es un evento en el que expertos y profesionales en diferentes campos, dialogan y problematizan sobre un tema actual de una forma diferente e informal. Su finalidad de escuchar opiniones diversas y realizar algunos postulados que contribuyan al trabajo posterior y que ayuden a fomentar inquietudes que despiertan una entretenida discusión.',
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          Text('Ver Encuentros'),
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
