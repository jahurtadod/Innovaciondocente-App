import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/noticia.dart';

class AsymmetricView extends StatelessWidget {
  final List<Noticia> noticias;

  AsymmetricView({Key key, this.noticias});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(0.0, 34.0, 16.0, 44.0),
      children: _buildColumns(context),
    );
  }

  List<Container> _buildColumns(BuildContext context) {
    // validate list has items
    if (noticias.isEmpty) return <Container>[];

    // build list
    return List.generate(_listItemCount(noticias.length), (int index) {
      double width = .59 * MediaQuery.of(context).size.width;
      Widget column;
      if (index % 2 == 0) {
        /// Even cases
        int bottom = _evenCasesIndex(index);
        column = TwoNoticiaCardColumn(
          /// TODO, check bottom and top
          bottom: noticias[bottom],
          top: noticias.length - 1 >= bottom + 1 ? noticias[bottom + 1] : null,
        );
        width += 32.0;
      } else {
        /// Odd cases
        column = OneNoticiaCardColumn(
          product: noticias[_oddCasesIndex(index)],
        );
      }
      return Container(
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: column,
        ),
      );
    }).toList();
  }

  ///  return `number of columns`
  int _listItemCount(int totalItems) {
    /// get asimetic size, every 3 items generate 2 colums
    return (totalItems % 3 == 0)
        // total number of columns matches totalItems
        ? totalItems ~/ 3 * 2
        // add column for last item
        : (totalItems / 3).ceil() * 2 - 1;
  }

  ///  return `truncated index of item`
  int _evenCasesIndex(int input) {
    return input ~/ 2 * 3;
  }

  int _oddCasesIndex(int input) {
    assert(input > 0);

    /// TODO: validate assert
    return (input / 2).ceil() * 3 - 1;
  }
}

///////////////////
///////////////////
///////////////////
///////////////////
class TwoNoticiaCardColumn extends StatelessWidget {
  TwoNoticiaCardColumn({
    this.bottom,
    this.top,
  }) : assert(bottom != null);

  final Noticia bottom, top;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      const spacerHeight = 44.0;

      double heightOfCards = (constraints.biggest.height - spacerHeight) / 2.0;
      double heightOfImages = heightOfCards - NoticiaCard.kTextBoxHeight;
      // TODO: Change imageAspectRatio calculation (104)
      // TODO: Change imageAspectRatio calculation (104)
      double imageAspectRatio =
          (heightOfImages >= 0.0 && constraints.biggest.width > heightOfImages)
              ? constraints.biggest.width / heightOfImages
              : 33 / 49;

      // TODO: Replace Column with a ListView (104)
      return ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsetsDirectional.only(start: 28.0),
            child: top != null
                ? NoticiaCard(
                    imageAspectRatio: imageAspectRatio,
                    product: top,
                  )
                : SizedBox(
                    height: heightOfCards,
                  ),
          ),
          SizedBox(height: spacerHeight),
          Padding(
            padding: EdgeInsetsDirectional.only(end: 28.0),
            child: NoticiaCard(
              imageAspectRatio: imageAspectRatio,
              product: bottom,
            ),
          ),
        ],
      );
    });
  }
}

class OneNoticiaCardColumn extends StatelessWidget {
  OneNoticiaCardColumn({this.product});

  final Noticia product;

  @override
  Widget build(BuildContext context) {
    // TODO: Replace Column with a ListView (104)
    return ListView(
      reverse: true,
      children: <Widget>[
        SizedBox(
          height: 40.0,
        ),
        NoticiaCard(
          product: product,
        ),
      ],
    );
  }
}

class NoticiaCard extends StatelessWidget {
  NoticiaCard({this.imageAspectRatio: 33 / 49, this.product})
      : assert(imageAspectRatio == null || imageAspectRatio > 0);

  final double imageAspectRatio;
  final Noticia product;

  static final kTextBoxHeight = 65.0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final imageWidget = Image.network(
      product.img,
      fit: BoxFit.cover,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AspectRatio(
          aspectRatio: imageAspectRatio,
          child: imageWidget,
        ),
        SizedBox(
          height: kTextBoxHeight * MediaQuery.of(context).textScaleFactor,
          width: 121.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // TODO(larche): Make headline6 when available
              Text(
                product == null ? '' : product.name,
                style: theme.textTheme.button,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: 4.0),
              // TODO(larche): Make subtitle2 when available
            ],
          ),
        ),
      ],
    );
  }
}
