import 'dart:async';

/// This file one of the main foundation
/// where it is used for creating the list view
/// models of the application.
/// It extends the [ViewLogic].
/// Used to manage list view data.
///
/// [DO NOT TOUCH THIS FILE!!!]

import 'model.dart';
import 'view_logic.dart';

abstract class ListViewLogic<T extends Model> extends ViewLogic {
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  /// Whenever you listen for new data.
  /// Subscribe to the listener so that it will
  /// not keep listening when this logic ends.
  void subscribe(StreamSubscription fromListener) =>
      fromListener == null ? null : _subscription = fromListener;
  StreamSubscription _subscription;

  /// The list view model data that is still in memory.
  Map<String, T> _cache = {};

  /// Get the list of data for the list view.
  List<T> get items => _items;
  List<T> _items = [];

  /// Add data to list of items for list view.
  void addItems(List<T> data) {
    for (Model each in data) {
      if (_cache.containsKey(each.id)) continue;
      _cache[each.id] = each;
      _items.insert(0, each);
    }
    refresh();
  }

  /// Replace the whole data with a new list of items
  /// for the list view
  void replaceItems(List<T> data) {
    if (data == null) return;
    _cache.clear();
    _items.clear();
    addItems(data);
    refresh();
  }

  /// Function for fetching the data.
  /// If [isNext] is true, [addItems].
  /// If [isNext] is false, [replaceItems].
  Future<void> fetch({bool isNext = false});
}
