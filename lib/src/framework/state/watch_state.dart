/// This file is one of the foundation
/// for watching the state management
/// if the widget in the widget tree
/// needs to be refreshed.
///
/// [DO NOT TOUCH THIS FILE!!!].

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_skeleton/src/framework/logic/logics.dart';
import 'package:provider_skeleton/src/framework/logic/view_logic.dart';

class WatchState<T extends ViewLogic> extends StatefulWidget {
  final Widget Function(BuildContext context, T model) builder;
  final Function(T) onModelReady;

  /// This is used for watching the state of the [ViewLogic].
  /// Any widgets under the  builder will be watch for refresh,
  /// when [setState] is called in [ViewLogic].
  WatchState({@required this.builder, this.onModelReady})
      : assert(builder != null);

  @override
  _WatchStateState<T> createState() => _WatchStateState<T>();
}

class _WatchStateState<T extends ViewLogic> extends State<WatchState<T>> {
  T _model = Logics.getIt<T>();

  @override
  void initState() {
    super.initState();
    _model?.initContext(context);
    Future.microtask(() {
      if (this.widget.onModelReady != null) this.widget.onModelReady(_model);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
        value: _model,
        child: Consumer<T>(
            builder: (context, T model, child) =>
                this.widget.builder(context, model)));
  }
}
