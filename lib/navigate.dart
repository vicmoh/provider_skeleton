/// This function is part of the foundation of the
/// this application state management framework.
/// It is used to navigate and providing to certain page.
///
/// [DO NOT TOUCH THIS FILE!!!].

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'view_logic.dart';

/// This class is used to create a navigator
/// where it will also provide models to
/// the descendent tree. By default it is using
/// the cupertino page route.
class Navigate {
  /// Function to navigate.
  /// [providers] is the models being provided to the
  /// descended of the [page] tree.
  /// [page] is the widget page the you want to go
  /// to, the widget must contain scaffold widget.
  /// [replaceAsRoot] replaces the [page] as the root
  /// of the page tree.
  static Future<void> to(
    BuildContext context, {
    List<ViewLogic> providers,
    @required Widget page,
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
