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

  /// Set the default order by function
  /// for ordering the list by default.
  int Function(T, T) get orderBy => _orderBy;
  int Function(T, T) _orderBy;
  bool _presortOnItemsAdded = false;

  /// Initialize function.
  /// If [presortOnItemsAdded] the items
  /// will not be sorted after it has been
  /// added. Instead it will be presorted
  /// on items added to the list.
  void init({
    int Function(T, T) orderBy,
    bool presortOnItemsAdded = false,
  }) {
    _orderBy = orderBy;
    _presortOnItemsAdded = _presortOnItemsAdded ?? false;
  }

  /// Add data to list of items for list view.
  void addItems(List<T> data) {
    if (data == null) return;
    if (_presortOnItemsAdded && orderBy != null) data.sort(orderBy);

    for (var each in data) {
      if (each == null) continue;
      if (_cache.containsKey(each.id)) {
        var index = _items.indexOf(each);
        _items[index] = each;
        continue;
      }
      _cache[each.id] = each;
      _items.add(each);
    }

    if (!_presortOnItemsAdded && orderBy != null) data.sort(orderBy);
  }

  /// Replace the whole data with a new list of items
  /// for the list view
  void replaceItems(List<T> data) {
    if (data == null) return;
    _cache.clear();
    _items.clear();
    this.addItems(data);
  }
}
