import 'package:flutter/material.dart';

class CoursesUtils {
  // TODO: move to correct folder
  static List<Color> getColors(String txt) {
    if (txt.contains('gestion'))
      return <Color>[
        Color(0xff364d9d),
        Color(0xff1ea3de),
      ];
    if (txt.contains('gestion-proyectos'))
      return <Color>[
        Color(0xff2aa9dc),
        Color(0xff2bb4e2),
      ];
    if (txt.contains('identidad'))
      return <Color>[
        Color(0xffd6332e),
        Color(0xfff0706f),
      ];
    if (txt.contains('pedagogia'))
      return <Color>[
        Color(0xff1d9e97),
        Color(0xff41b8c0),
      ];
    if (txt.contains('investigacion'))
      return <Color>[
        Color(0xfff36a22),
        Color(0xfff89a1c),
      ];
    if (txt.contains('tic'))
      return <Color>[
        Color(0xff1291c6),
        Color(0xff44b0de),
      ];
    return <Color>[
      Colors.purple,
      Colors.purpleAccent,
    ];
  }

  static String getNameType(String txt) {
    if (txt.contains('gestion')) return "Gestión académica";
    if (txt.contains('gestion-proyectos')) return "Gestión de proyectos";
    if (txt.contains('identidad')) return "Identidad UTPL";
    if (txt.contains('pedagogia')) return "Pedagogía";
    if (txt.contains('investigacion')) return "Investigación";
    if (txt.contains('tic')) return "Tic's";
    return 'Not Found';
  }
}
