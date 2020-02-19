/// This file one of the main foundation
/// where it is used for creating the view
/// models of the application.
///
/// [DO NOT TOUCH THIS FILE!!!].

import 'package:flutter/material.dart';

/// View state is how what the view model is doing.
/// If the view state is [asLoading] means that an
/// async process exist. While [asComplete] is when state
/// is waiting doing nothing waiting for user response.
/// [asError] is when an error occurred.
enum ViewState { asLoading, asComplete, asError }

/// This is class model that is used as the view model.
/// View models are extended with [ViewLogic].
abstract class ViewLogic extends ChangeNotifier {
  /// Get the current state of the [ViewLogic].
  ViewState get currentState => _currentState ?? ViewState.asComplete;
  ViewState _currentState = ViewState.asComplete;

  /// Get the context of the state.
  BuildContext get context => _context;
  BuildContext _context;
  void initContext(BuildContext context) => _context = context;

  /// Set [ViewState].
  /// All data in using this [ViewLogic] will be updated.
  void refresh([ViewState state]) {
    if (state != null) _currentState = state;
    notifyListeners();
  }
}
