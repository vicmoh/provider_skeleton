import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_skeleton/provider_skeleton.dart';
import '../logic/logics.dart';

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

  /// The logic model. If this is null.
  /// it will use the global model provided.
  /// If this is logic is placed, it will use
  /// this logic instead.
  final T logic;

  /// Get logic from store.
  final String store;

  /// When the logic is ready. Called in initState.
  final Function(T) onReady;

  /// When the widget is being disposed.
  final Function(T) onDispose;

  /// This is used for watching the state of the [ViewLogic].
  /// Any widgets under the  builder will be watch for refresh,
  /// when [setState] is called in [ViewLogic]
  WatchState({
    @required this.builder,
    this.onReady,
    this.onDispose,
    this.logic,
    this.store,
  }) : assert(builder != null);

  /// This is used for watching the state of the [ViewLogic].
  /// Any widgets under the  builder will be watch for refresh,
  WatchState.fromStore(
    this.store, {
    @required this.builder,
    this.onReady,
    this.onDispose,
  })  : assert(builder != null),
        assert(store != null),
        this.logic = null;

  @override
  _WatchStateState<T> createState() => _WatchStateState<T>();
}

class _WatchStateState<T extends ViewLogic> extends State<WatchState<T>> {
  T _model;

  @override
  void initState() {
    super.initState();
    if (this.widget.store == null && this.widget.logic == null)
      _model = Logics.getIt<T>();
    else if (this.widget.store != null)
      _model = Logics.getStore(this.widget.store);
    else if (this.widget.logic != null) _model = this.widget.logic;
    assert(_model != null, 'WatchState(): ViewLogic is not assigned.');
    _model.initContext(context);
    if (this.widget.onReady != null) this.widget.onReady(_model);
  }

  @override
  void dispose() {
    if (this.widget.onDispose != null) this.widget.onDispose(_model);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>.builder(
      builder: (context) =>  _model,
      child: Consumer<T>(builder: (context, T model, child) {
        _model.initContext(context);
        return this.widget.builder(context, model);
      }));
}
