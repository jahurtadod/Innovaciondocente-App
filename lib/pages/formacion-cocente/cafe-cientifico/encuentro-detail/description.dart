import 'package:flutter/material.dart';

class EncuentroDescription extends StatefulWidget {
  final String description;

  const EncuentroDescription({
    Key key,
    this.description,
  }) : super(key: key);

  @override
  _EncuentroDescriptionState createState() => _EncuentroDescriptionState();
}

class _EncuentroDescriptionState extends State<EncuentroDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildDescription(),
        SizedBox(height: 5),
        _buildbutton(),
      ],
    );
  }

  Widget _buildbutton() {
    String opt = isExpanded ? 'menos' : 'más';

    return InkWell(
      // TODO: change color
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Ver $opt'),
          SizedBox(width: 3),
          Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
        ],
      ),
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }

  Widget _buildDescription() => isExpanded
      ? Text(
          widget.description.trim(),
          textAlign: TextAlign.justify,
        )
      : Text(
          widget.description.trim(),
          maxLines: 5,
          textAlign: TextAlign.justify,
          overflow: TextOverflow.ellipsis,
        );
}
