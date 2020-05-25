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
  final BuildContext context;

  /// The recent context used, when navigation
  /// is called, useful for notification handling,
  /// or determining which context you are in.
  static get recentContext => _recentContext;
  static BuildContext _recentContext;

  /// A router for navigating to certain pages.
  /// The router needs the [context] of the current state.
  RouteSystem(this.context) {
    _recentContext = this.context;
  }

  /// Use route system from recent context used.
  RouteSystem.fromRecentContext() : this.context = _recentContext;
}
