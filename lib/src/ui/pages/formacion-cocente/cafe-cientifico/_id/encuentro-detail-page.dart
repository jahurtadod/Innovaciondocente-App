import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/src/models/encuentro.dart';
import 'package:innovaciondocente_app/src/resources/colors.dart';
import 'package:innovaciondocente_app/src/resources/filters.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/cafe-cientifico/_id/guests-detail.dart';
import 'package:innovaciondocente_app/src/ui/pages/formacion-cocente/cafe-cientifico/_id/title-encuentro-detail.dart';
import 'package:innovaciondocente_app/src/ui/widgets/expandable-description.dart';

class EncuentroDetailPage extends StatelessWidget {
  final Encuentro encuentro;
  EncuentroDetailPage({
    Key key,
    this.encuentro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          SliverSafeArea(
            top: false,
            sliver: _buildBody(context),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildBody(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(15),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          TitleEncuentroDetail(name: encuentro.name),
          SizedBox(height: 8),
          Text(
            Filters.date(encuentro.date),
            style: Theme.of(context).textTheme.overline,
          ),
          (this.isActive()) ? SizedBox(height: 13) : Container(),
          (this.isActive())
              ? RaisedButton(
                  child: Text(
                    'Inscribete',
                    style: Theme.of(context).accentTextTheme.button,
                  ),
                  onPressed: () {
                    Filters.launchURL(
                        'https://innovaciondocente-utpl.firebaseapp.com/formacion-docente/cafe-cientifico/inscripcion?id=${encuentro.id}');
                  },
                  color: IndevColors.formacion,
                )
              : Container(),
          SizedBox(height: 13),
          ExpandableDescription(
            description: encuentro.description,
          ),
          GuestsDetails(guests: encuentro.guests),
        ]),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: 280,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Hero(
          tag: encuentro.id,
          child: FadeInImage(
            image: NetworkImage(
              encuentro.img,
            ),
            placeholder: AssetImage('assets/images/default.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  bool isActive() {
    if (encuentro.postulations == null) return false;
    DateTime today = DateTime.now();
    return today.difference(encuentro.postulations).inDays <= 0;
  }
}
