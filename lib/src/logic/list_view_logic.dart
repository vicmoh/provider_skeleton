import 'dart:async';
import 'package:provider_skeleton/src/model/model.dart';
import 'view_logic.dart';
import '../model/uniquify_list_model.dart';

/// This file one of the main foundation
/// where it is used for creating the list view
/// models of the application.
/// It extends the [ViewLogic].
/// Used to manage list view data.
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

  /// A list that will uniquify the model.
  UniquifyListModel _list = UniquifyListModel<T>();

  /// Get the list of data for th list view.
  List<T> get items => _list.items;

  /// Add data to list of items for list view.
  void addItems(List<T> data) {
    if (data == null) return;
    _list.addItems(data);
    refresh();
  }

  /// Replace the whole data with a new list of items
  /// for the list view
  void replaceItems(List<T> data) {
    if (data == null) return;
    _list.replaceItems(data);
    refresh();
  }
}
