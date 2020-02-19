/// This file contain a new state widget
/// used to only set state partially
/// under the widget subtree.
///
/// [DO NOT TOUCH THIS FILE!!!].

import 'package:flutter/material.dart';
import 'set_state_callback.dart';

class NewState extends StatefulWidget {
  final Widget Function(BuildContext, SetState) builder;
  final void Function(SetState) onInit;

  /// A widget used to get the state state the
  /// is wrap underneath, so that you can refresh
  /// only a partial of the subtree for
  /// better performance.
  NewState({
    Key key,
    @required this.builder,
    this.onInit,
  })  : assert(builder != null),
        super(key: key);

  @override
  _NewStateState createState() => _NewStateState();
}

class _NewStateState extends State<NewState> {
  @override
  void initState() {
    super.initState();
    if (this.widget?.onInit != null) this.widget.onInit(this.setState);
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.builder(context, this.setState);
  }
}
