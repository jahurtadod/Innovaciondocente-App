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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Ver $opt',
            style: Theme.of(context).textTheme.overline,
          ),
          Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            size: 18,
          ),
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
