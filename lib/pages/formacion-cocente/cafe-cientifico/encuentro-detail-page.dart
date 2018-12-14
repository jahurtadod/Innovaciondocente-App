import 'package:flutter/material.dart';
import 'package:innovaciondocente_app/classes/filters.dart';
import 'package:innovaciondocente_app/pages/formacion-cocente/cafe-cientifico/description.dart';
import 'package:innovaciondocente_app/services/formacion-docente/cafe-cientifico/encuentro.dart';

class EncuentroDetailPage extends StatelessWidget {
  final Encuentro encuentro;
  EncuentroDetailPage({
    Key key,
    this.encuentro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.access_alarm),
        label: Text('Inscribete'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildBody(context),
        ],
      ),
    );
  }

  SliverPadding _buildBody(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 65),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Text(
            encuentro.name,
            style: Theme.of(context).primaryTextTheme.title,
          ),
          SizedBox(height: 10),
          Text(
            Filters.date(encuentro.date),
            style: Theme.of(context).textTheme.overline,
          ),
          SizedBox(height: 15),
          EncuentroDescription(
            description: encuentro.description,
          ),
          SizedBox(height: 15),
          Row(
            children: <Widget>[
              Icon(Icons.people),
              SizedBox(width: 5),
              Text(
                'Invitados',
                style: Theme.of(context).primaryTextTheme.subtitle,
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment
            : CrossAxisAlignment.start,
            children: encuentro.guests
                .map(
                  (guest) => Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${guest.name}',
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                              // TextSpan(text: guest.description.trim()),
                            ],
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                      ),
                )
                .toList(),
          )
        ]),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      expandedHeight: 280,
      actions: <Widget>[
        CloseButton(),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: FadeInImage(
          image: NetworkImage(
            encuentro.img,
          ),
          placeholder: AssetImage('assets/images/default.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
