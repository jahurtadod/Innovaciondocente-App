import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/resources/colors.dart';

final pages = [
  new PageViewModel(
    IndevColors.formacion,
    'assets/formacion.png',
    'Formación Docente',
    'Busca llevar una constante mejora de cada uno de nuestros formadores.',
    true,
  ),
  new PageViewModel(
    IndevColors.innovacion,
    'assets/inovacion.png',
    'Innovación Docente',
    'Conoce las nuevas tendencias de nuestros Ascenderes.',
    true,
  ),
  new PageViewModel(
    IndevColors.observatorio,
    'assets/observatorio.png',
    'EduTendencias',
    'Conoce las noticias y tendencias de enseñanza.',
    true,
  ),
  new PageViewModel(
    IndevColors.black,
    'assets/icon.png',
    'Acopañanos en esta nueva experencia.',
    '',
    false,
  ),
];

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;
  // final bool continueStart;

  Page({
    this.viewModel,
    this.percentVisible = 1.0,
    // this.continueStart = false,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        color: viewModel.color,
        child: new Opacity(
          opacity: percentVisible,
          child: new Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            new Transform(
              transform: new Matrix4.translationValues(0.0, 50.0 * (1.0 - percentVisible), 0.0),
              child: new Padding(
                padding: new EdgeInsets.only(bottom: 25.0),
                child: new Image.asset(
                  viewModel.heroAssetPath,
                  width: 150.0,
                  height: 150.0,
                  colorBlendMode: BlendMode.srcIn,
                  color: Colors.white,
                ),
              ),
            ),
            new Transform(
              transform: new Matrix4.translationValues(0.0, 50.0 * (1.0 - percentVisible), 0.0),
              child: new Padding(
                padding: new EdgeInsets.all(20.0),
                child: new Text(
                  viewModel.title,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: (viewModel.continueStart) ? 25.0 : 20.0,
                  ),
                ),
              ),
            ),
            new Transform(
              transform: new Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: new Padding(
                padding: new EdgeInsets.only(left: 30.0, right: 30.0),
                child: Center(
                  child: (viewModel.continueStart)
                      ? new Text(
                          viewModel.body,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        )
                      : new OutlineButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/start');
                          },
                          textColor: Colors.white,
                          color: Colors.blue.shade900,
                          child: new Text(
                            "COMENZAR",
                          ),
                        ),
                ),
              ),
            ),
          ]),
        ));
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final bool continueStart;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.continueStart,
  );
}
