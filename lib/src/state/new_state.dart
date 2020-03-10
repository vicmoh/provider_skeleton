import 'package:flutter/material.dart';
import 'set_state_callback.dart';

/// This file contain a new state widget
/// used to only set state partially
/// under the widget subtree.
class NewState extends StatefulWidget {
  /// The widget builder for the state to be wrapped.
  final Widget Function(BuildContext, SetState) builder;

  /// When this state being initialize.
  final void Function(SetState) onInitState;

  /// When this state being disposed.
  final void Function(SetState) onDispose;

  /// A widget used to get the state state the
  /// is wrap underneath, so that you can refresh
  /// only a partial of the subtree for
  /// better performance.
  NewState({
    Key key,
    @required this.builder,
    this.onInitState,
    this.onDispose,
  })  : assert(builder != null),
        super(key: key);

  @override
  _NewStateState createState() => _NewStateState();
}

class _NewStateState extends State<NewState> {
  @override
  void initState() {
    super.initState();
    if (this.widget?.onInitState != null)
      this.widget.onInitState(this.setState);
  }

  @override
  void dispose() {
    if (this.widget?.onDispose != null) this.widget.onDispose(this.setState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.builder(context, this.setState);
  }
}
