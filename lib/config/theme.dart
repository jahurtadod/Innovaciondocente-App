import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/config/colors.dart';

ThemeData ID_buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: ID_yellow,
    primaryColor: ID_blue,
    buttonColor: ID_yellow,
    scaffoldBackgroundColor: Colors.white,
    errorColor: Colors.red,
    // text theme
    textTheme: _buildTextTheme(base: base.textTheme),
    primaryTextTheme: _buildTextTheme(base: base.primaryTextTheme, color: Colors.white),
    accentTextTheme: _buildTextTheme(base: base.accentTextTheme),

    // icon theme
    primaryIconTheme: base.iconTheme.copyWith(color: Colors.white),
    accentIconTheme: base.iconTheme.copyWith(color: Colors.black),
    // inputDecorationTheme: InputDecorationTheme(
    //   border: CutCornersBorder(), // Replace code
    // ),
  );
}

TextTheme _buildTextTheme({
  TextTheme base,
  Color color = Colors.black,
}) {
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
        button: base.button.copyWith(color: color),
      )
      .apply(
        displayColor: color,
        bodyColor: color,
      );
}
