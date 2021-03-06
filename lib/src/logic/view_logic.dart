import 'package:flutter/material.dart';

/// View state is how what the view model is doing.
/// If the view state is [asLoading] means that an
/// async process exist. While [asComplete] is when state
/// is waiting doing nothing waiting for user response.
/// [asError] is when an error occurred.
enum ViewState { asLoading, asComplete, asError }

abstract class ViewLogic extends ChangeNotifier {
  /// Determine if this change notifier has been initialize.
  bool get isInitialized => _isInitialized;
  bool _isInitialized = false;

  /// Determine if this change notifier has been disposed.
  bool get isDisposed => _isDisposed;
  bool _isDisposed = false;

  /// This is class model that is used as the view model.
  /// View models are extended with [ViewLogic].
  ViewLogic() {
    this.initState();
  }

  /// The initial state of the view logic
  /// when the the logic first created.
  void initState() {
    _isInitialized = true;
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  /// Determine if the current state is loading state.
  /// Return true if it is.
  bool get isLoading => _currentState == ViewState.asLoading;

  /// Get the current state of the [ViewLogic].
  ViewState get currentState => _currentState ?? ViewState.asComplete;
  ViewState _currentState = ViewState.asComplete;

  /// Get the context of the state.
  BuildContext get context => _context;
  BuildContext _context;
  void initContext(BuildContext context) =>
      context == null ? null : _context = context;

  /// Set [ViewState].
  /// All data in using this [ViewLogic] will be updated.
  void refresh([ViewState state]) {
    if (state != null) _currentState = state;
    notifyListeners();
  }
}
