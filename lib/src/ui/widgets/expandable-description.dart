import 'package:flutter/material.dart';

class ExpandableDescription extends StatefulWidget {
  final String description;

  const ExpandableDescription({
    Key key,
    this.description,
  }) : super(key: key);

  @override
  _ExpandableDescriptionState createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          widget.description.trim(),
          maxLines: expanded ? defaultTextStyle.maxLines : 5,
          textAlign: TextAlign.justify,
          overflow: expanded ? defaultTextStyle.overflow : TextOverflow.ellipsis,
        ),
        SizedBox(height: 5),
        _buildbutton(),
      ],
    );
  }

  Widget _buildbutton() {
    String opt = expanded ? 'menos' : 'más';

    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Ver $opt',
            style: Theme.of(context).textTheme.overline,
          ),
          Icon(
            expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            size: 18,
          ),
        ],
      ),
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
