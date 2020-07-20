import './model.dart';

/// A Lis mixin that contains list items
/// of models that uniquify them based
/// on the ID. If id already exist in the
/// list, don't add them.
class UniquifyListModel<T extends Model> {
  /// The list view model data that is still in memory.
  Map<String, T> _cache = {};

  /// Get the list of data for th list view.
  List<T> get items => _items ?? [];
  List<T> _items = [];

  /// Get the list of data for th list view.
  List<T> getItems<T>() => _items ?? [];

  /// Add data to list of items for list view.
  void addItems(List<T> data) {
    if (data == null) return;
    for (Model each in data) {
      if (each == null) continue;
      if (_cache.containsKey(each.id)) {
        var index = _items.indexOf(each);
        _items[index] = each;
        continue;
      }
      _cache[each.id] = each;
      _items.insert(0, each);
    }
  }

  /// Replace the whole data with a new list of items
  /// for the list view
  void replaceItems(List<T> data) {
    if (data == null) return;
    _cache.clear();
    _items.clear();
    addItems(data);
  }
}
