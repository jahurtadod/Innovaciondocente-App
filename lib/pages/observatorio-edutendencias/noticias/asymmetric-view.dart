import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/noticia.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/noticias/double-news-column.dart';
import 'package:innovaciondocente_app/pages/observatorio-edutendencias/noticias/single-news-column.dart';

class AsymmetricView extends StatelessWidget {
  final List<Noticia> noticias;

  AsymmetricView({Key key, this.noticias});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      children: _buildColumns(context),
    );
  }

  List<Container> _buildColumns(BuildContext context) {
    if (noticias.isEmpty) return <Container>[];

    // build list
    return List.generate(_listItemCount(noticias.length), (int index) {
      double width = .85 * MediaQuery.of(context).size.width;
      if (index % 2 == 0) {
        /// Even cases
        int bottom = _evenCasesIndex(index);
        return Container(
          width: width,
          child: DoubleNewsColumn(
            top: noticias[bottom],
            bottom: noticias.length - 1 >= bottom + 1 ? noticias[bottom + 1] : null,
          ),
        );
      }

      /// Odd cases
      return Container(
        width: width,
        child: SingleNewsColumn(
          noticia: noticias[_oddCasesIndex(index)],
        ),
      );
    }).toList();
  }

  ///  return `number of columns`
  int _listItemCount(int totalItems) {
    return (totalItems % 3 == 0)
        // total number of columns matches totalItems
        ? totalItems ~/ 3 * 2
        // add column for last item
        : (totalItems / 3).ceil() * 2 - 1;
  }

  int _evenCasesIndex(int input) {
    return input ~/ 2 * 3;
  }

  int _oddCasesIndex(int input) {
    assert(input > 0);
    return (input / 2).ceil() * 3 - 1;
  }
}
