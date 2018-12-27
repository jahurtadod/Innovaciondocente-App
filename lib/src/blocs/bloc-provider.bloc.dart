import 'package:flutter/material.dart';

/// abstrac class that includes`[dispose]`, method to avoid menory leaks
abstract class BlocBase {
  void dispose();
}

/// manage multiple blocs
class BlocsData extends StatefulWidget {
  BlocsData({
    this.child,
  });

  final Widget child;

  static BlocsData init() => BlocsData();

  @override
  BlocsDataState createState() {
    return new BlocsDataState();
  }
}

class BlocsDataState extends State<BlocsData> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// BLoC provider
class BlocProvider extends InheritedWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.blocs,
  }) : super(child: child, key: key);

  final BlocsData blocs;
  final Widget child;

  static BlocProvider of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
