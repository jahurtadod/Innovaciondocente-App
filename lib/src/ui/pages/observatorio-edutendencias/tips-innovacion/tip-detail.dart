import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/classes/tips-innovacion.dart';
import 'package:innovaciondocente_app/config/colors.dart';

class TipDetail extends StatelessWidget {
  const TipDetail({
    Key key,
    @required this.tip,
  }) : super(key: key);

  final TipInnovacion tip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  CustomScrollView _buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('Tip Innovación'),
          forceElevated: true,
          floating: true,
          snap: true,
        ),
        SliverPadding(
          padding: EdgeInsets.all(15.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Text(
                  tip.name,
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 10),
                // image
                _buildImage(),
                SizedBox(height: 10),
                // chip category
                _buildChip(context),
                SizedBox(height: 10),
                // date
                Text(Filters.date(tip.created)),
                SizedBox(height: 10),
                //description
                Text(
                  tip.description,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildChip(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 2.5,
            horizontal: 5.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: IndevColors.observatorio,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(3.0),
            ),
          ),
          child: Text(
            tip.tag.toUpperCase(),
            style: Theme.of(context).textTheme.overline,
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Hero(
        tag: tip.id,
        child: FadeInImage(
          height: 170.0,
          width: double.infinity,
          image: NetworkImage(tip.img),
          placeholder: AssetImage('assets/images/default.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    Function goto = () {
      Filters.launchURL(tip.link);
    };

    return tip.tag == 'videos'
        ? FloatingActionButton.extended(
            backgroundColor: IndevColors.observatorio,
            icon: Icon(Icons.play_arrow),
            label: Text("Abrir Video"),
            onPressed: goto,
          )
        : FloatingActionButton.extended(
            backgroundColor: IndevColors.observatorio,
            icon: Icon(Icons.link),
            label: Text("Abrir Enlace"),
            onPressed: goto,
          );
  }
}
