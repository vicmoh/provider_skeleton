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

  /// When the logic is ready.
  final Function(T) onReady;

  /// This is used for watching the state of the [ViewLogic].
  /// Any widgets under the  builder will be watch for refresh,
  /// when [setState] is called in [ViewLogic]
  ///
  /// Use WatchState from logic or from store instead.
  @deprecated
  WatchState({
    @required this.builder,
    this.onReady,
    this.logic,
    this.store,
  }) : assert(builder != null);

  /// This is used for watching the state of the [ViewLogic].
  /// Any widgets under the  builder will be watch for refresh,
  WatchState.fromLogic(
    this.logic, {
    @required this.builder,
    this.onReady,
  })  : assert(builder != null),
        assert(logic != null),
        this.store = null;

  /// This is used for watching the state of the [ViewLogic].
  /// Any widgets under the  builder will be watch for refresh,
  WatchState.fromStore(
    this.store, {
    @required this.builder,
    this.onReady,
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
    if (this.widget.store != null) _model = Logics.getStore(this.widget.store);
    if (this.widget.logic != null) _model = this.widget.logic;
    assert(_model != null, 'WatchState(): ViewLogic is not assigned.');
    _model.initContext(context);
    if (this.widget.onReady != null) this.widget.onReady(_model);
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<T>.value(
      value: this.widget.logic ?? _model,
      child: Consumer<T>(builder: (context, T model, child) {
        _model = model;
        _model.initContext(context);
        return this.widget.builder(context, model);
      }));
}
