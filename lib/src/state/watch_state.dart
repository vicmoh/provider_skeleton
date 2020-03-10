import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_skeleton/provider_skeleton.dart';

/// This file is one of the foundation
/// for watching the state management
/// if the widget in the widget tree
/// needs to be refreshed.
class WatchState<T extends ViewLogic> extends StatefulWidget {
  /// The widget builder on which the state needs
  /// to be watch. If the view logic request the state
  /// to be updated, the corresponding widget that is being
  /// watch will be updated.
  final Widget Function(BuildContext context, T model) builder;

  /// When the logic is ready.
  final Function(T) onReady;

  /// This is used for watching the state of the [ViewLogic].
  /// Any widgets under the  builder will be watch for refresh,
  /// when [setState] is called in [ViewLogic].
  WatchState({
    @required this.builder,
    this.onReady,
  }) : assert(builder != null);

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
      if (this.widget.onReady != null) this.widget.onReady(_model);
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
