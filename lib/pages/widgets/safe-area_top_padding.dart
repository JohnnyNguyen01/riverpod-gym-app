import 'package:flutter/material.dart';

///This is used to provide the topPadding from SafeArea to the
///Workout Bottom Sheet widget, as modal bottom sheets do not respect the
///safeArea.
class RootMediaQueryDataHolder extends InheritedWidget {
  final MediaQueryData data;

  RootMediaQueryDataHolder({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(data != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static RootMediaQueryDataHolder of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<RootMediaQueryDataHolder>();
  }
}
