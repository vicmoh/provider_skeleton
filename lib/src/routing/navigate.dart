import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider_skeleton/src/logic/view_logic.dart';

/// This function is part of the foundation of the
/// this application state management framework.
/// It is used to navigate and providing to certain page.
///
/// For example:
/// ```dart
/// void navToHomePage() => Navigate(context).to(HomeScreen(),
///     replaceAsRoot: true,
///     providers: [PhoneVerificationLogic()]);
/// ```
///
/// This class is used to create a navigator
/// where it will also provide models to
/// the descendent tree. By default it is using
/// the cupertino page route.
class Navigate {
  final BuildContext context;
  Navigate(this.context);

  /// Function to navigate.
  /// [providers] is the models being provided to the
  /// descended of the [page] tree.
  /// [page] is the widget page the you want to go
  /// to, the widget must contain scaffold widget.
  /// [replaceAsRoot] replaces the [page] as the root
  /// of the page tree.
  Future<void> to(
    Widget page, {
    List<ViewLogic> providers,
    bool replaceAsRoot = false,
  }) {
    assert(context != null);
    List<SingleChildWidget> multiProviders = [];
    providers?.forEach(
        (el) => multiProviders.add(ChangeNotifierProvider.value(value: el)));
    if (replaceAsRoot)
      return Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
              builder: (_) => multiProviders.length == 0
                  ? page
                  : MultiProvider(providers: multiProviders, child: page)),
          (_) => false);
    else
      return Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (_) => multiProviders.length == 0
                  ? page
                  : MultiProvider(providers: multiProviders, child: page)));
  }
}
