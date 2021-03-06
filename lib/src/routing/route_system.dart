import 'package:flutter/material.dart';

/// This class is used to manage the navigation and providing
/// the models to that page and its subtree.
///
/// Example of creating a route int [Router]:
///
/// ```dart
/// Future<void> navToHomePage(BuildContext context) =>
///   Navigate.to(context,
///     replaceAsRoot: true, providers: [PostLogic()], page: HomePage());
/// ```
abstract class RouteSystem {
  /// The widget current context.
  final BuildContext context;

  static List<BuildContext> _contexts = [];

  /// The recent context used, when navigation
  /// is called, useful for notification handling,
  /// or determining which context you are in.
  static BuildContext get recentContext {
    _contexts = _contexts.where((element) => element != null).toList();
    return _contexts.last;
  }

  /// A router for navigating to certain pages.
  /// The router needs the [context] of the current state.
  RouteSystem(this.context) {
    _contexts.add(context);
  }

  /// Go back to previous page.
  void pop() {
    _contexts.removeLast();
    Navigator.pop(context);
  }
}
