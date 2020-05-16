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

  /// The logic model. If this is null.
  /// it will use the global model provided.
  /// If this is logic is placed, it will use
  /// this logic instead.
  final T logic;

  /// When the logic is ready.
  final Function(T) onReady;

  /// This is used for watching the state of the [ViewLogic].
  /// Any widgets under the  builder will be watch for refresh,
  /// when [setState] is called in [ViewLogic].
  WatchState({
    @required this.builder,
    this.onReady,
    this.logic,
  }) : assert(builder != null);

  @override
  _WatchStateState<T> createState() => _WatchStateState<T>();
}

class _WatchStateState<T extends ViewLogic> extends State<WatchState<T>> {
  T _model;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Future.microtask(() {
      _model = this.widget.logic ?? Logics.getIt<T>();
      _model?.initContext(context);
      if (this.widget.onReady != null) this.widget.onReady(_model);
    });
  }

  @override
  void dispose() {
    _model?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _model?.initContext(context);
    return ChangeNotifierProvider<T>.value(
        value: this.widget.logic ?? _model,
        child: Consumer<T>(builder: (context, T model, child) {
          _model?.initContext(context);
          return this.widget.builder(context, model);
        }));
  }
}
