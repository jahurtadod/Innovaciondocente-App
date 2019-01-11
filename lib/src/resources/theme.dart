import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/resources/colors.dart';

class IndevTheme {
  static ThemeData theme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      accentColor: IndevColors.blue,

      // text theme
      textTheme: _buildTextTheme(base: base.textTheme),
      primaryTextTheme: _buildTextTheme(base: base.primaryTextTheme, color: Colors.black),
      accentTextTheme: _buildTextTheme(base: base.accentTextTheme, color: Colors.white),

      // icon theme
      iconTheme: base.iconTheme.copyWith(color: Colors.black),
      primaryIconTheme: base.iconTheme.copyWith(color: Colors.black),
      accentIconTheme: base.iconTheme.copyWith(color: Colors.white),
    );
  }

  static TextTheme _buildTextTheme({
    TextTheme base,
    Color color = Colors.black,
  }) {
    return base
        .copyWith(
          headline: base.headline.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 21,
          ),
          title: base.title.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
          // caption: base.caption.copyWith(
          //   fontWeight: FontWeight.w400,
          //   fontSize: 14.0,
          // ),
          overline: base.overline.copyWith(
            fontSize: 13.0,
          ),
        )
        .apply(
          displayColor: color,
          bodyColor: color,
        );
  }
}
