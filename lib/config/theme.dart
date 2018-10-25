import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/config/colors.dart';

ThemeData id_buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: ID_yellow,
    primaryColor: ID_blue,
    buttonColor: ID_yellow,
    scaffoldBackgroundColor: Colors.white,
    cardColor: ID_blue,
    errorColor: Colors.red,

    // text theme
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),

    primaryIconTheme: base.iconTheme.copyWith(color: ID_blue),
    inputDecorationTheme: InputDecorationTheme(
        // border: CutCornersBorder(), // Replace code
        ),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      )
      .apply(
        displayColor: Colors.white,
        bodyColor: Colors.black,
      );
}
