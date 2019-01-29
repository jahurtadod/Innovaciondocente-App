import 'package:flutter/material.dart';
import 'package:Ascendere_UTPL/src/models/encuentro.dart';

class GuestsDetails extends StatelessWidget {
  const GuestsDetails({
    Key key,
    @required this.guests,
  }) : super(key: key);

  final List<Guest> guests;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: _buildTileTitle(
            title: Text(
              'Invitados',
              style: Theme.of(context).textTheme.subtitle,
            ),
            icon: Icons.people,
          ),
        ),
      ]..addAll(guests.map(_buildGuestTile)),
    );
  }

  Widget _buildGuestTile(guest) {
    return ExpansionTile(

      title: _buildTileTitle(
        title: Text(guest.name),
        icon: Icons.person,
        
      ),
      children: <Widget>[
        Text(
          guest.description,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget _buildTileTitle({
    @required Text title,
    @required IconData icon,
  }) {
    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(width: 15),
        Expanded(
          child: title,
        ),
      ],
    );
  }
}
