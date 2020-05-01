import 'package:meta/meta.dart';

/// This class is the foundation used to extends
/// and the generic model where data is being used
/// for the [ListViewLogic].
abstract class Model {
  /// Get unique id for dummy model.
  /// For each call, id will increment.
  static String get uniqueIdForDummy =>
      'uniqueIdForDummy${++_uniqueIdForDummy}';
  static int _uniqueIdForDummy = 0;

  /// Abstract model that define the model this initialize
  /// the caching system. For every extend of this class
  /// it will add to the cache bucket when instantiating.
  /// Please beware that [timestamp] if null, it will
  /// be default time as now, when this object is created.
  Model({@required String id, DateTime timestamp}) {
    _setId(id);
    setTimestamp(timestamp ?? DateTime.now());
  }

  /// Create a model from JSON map.
  Model.fromJson(Map json, {String id}) {
    _setId(id ?? json['id']);
  }

  /// Create JSON map from this model.
  Map toJson();

  /* -------------------------------- Model ID -------------------------------- */

  String _id;

  /// Get the ID of this model.
  String get id {
    assert(_id != null);
    return _id;
  }

  /// This id can only be set once, if id already exist
  /// it will not overwrite. You can do [super.id] or [_setId]
  /// which is the exact same thing.
  void _setId(String val) {
    assert(
        val != null,
        '\n__________________________________________________\n' +
            'One of the model is missing an ID. When extending a model, ' +
            'initialized ID with super(id: "someUniqueId")' +
            '\n__________________________________________________\n');
    if (_id != null) return;
    _id = val;
  }

  /* -------------------------------- Timestamp ------------------------------- */

  DateTime _timestamp;

  /// Timestamp of when the model was create.
  DateTime get timestamp {
    assert(_timestamp != null);
    return _timestamp;
  }

  /// Set the timestamp of when the model was created.
  /// You can only set the timestamp model once.
  /// You can do [setTimestamp] or [timestamp] which
  /// is the exact same thing.
  set timestamp(DateTime val) => setTimestamp(val);

  /// Set the timestamp of when the model was created.
  /// You can only set the timestamp model once.
  /// You can do [setTimestamp] or [timestamp] which
  /// is the exact same thing.
  void setTimestamp(DateTime val) {
    assert(_timestamp == null,
        'The setTimestamp() function should only be called once.');
    if (_timestamp != null) return;
    _timestamp = val;
  }

  /* --------------------------------- Others --------------------------------- */

  /// Compare model based on timestamp which
  /// will order the list by recent timestamp.
  static int orderByRecent(Model a, Model b) =>
      a == null || b == null || a._timestamp == null || b._timestamp == null
          ? 0
          : b.timestamp.compareTo(a.timestamp);

  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(model) {
    if (this.hashCode == model.hashCode) return true;
    if (model is Model && this.id == model.id) return true;
    return false;
  }

  @override
  String toString() => toJson().toString();
}

/* -------------------------------------------------------------------------- */
/*                                   Caching                                  */
/* -------------------------------------------------------------------------- */

class CacheSystem {
  /// Global static cache for tracking the
  /// all the data cache.
  static Map<int, dynamic> _cache = {};

  /// Check if this model exist in the cache.
  bool isExist<T>(T model) {
    if (_cache.containsKey(this.hashCode))
      return true;
    else
      return false;
  }

  /// Gat data from cache.
  /// For example to get the cache data:
  /// ```dart
  /// Post data = getFromCache<Post>();
  /// ```
  /// [Important]: The [id] must be set or exist
  /// before calling this function.
  Model getFromCache<T>(T model) {
    if (_cache.containsKey(this.hashCode))
      return _cache[model.hashCode];
    else
      return null;
  }

  /// Add and track to cache. You
  /// can retrieve the cache back from
  /// from by using [getFromCache] function.
  /// You can add tot cache while setting the model
  /// an ID with [_setId] parameter, this will
  /// call [_setId] function.
  void addToCache<T>(T model) {
    if (model == null) return;
    _cache[model.hashCode] = model;
  }

  /// Print all the cached data.
  static void printAllCachedData() {
    print('_____ Cache data _____');
    _cache.forEach(
        (cacheId, model) => print('Cache ID: $cacheId, Model: $model'));
  }
}

/* -------------------------------------------------------------------------- */
/*                           Uniquify the list model                          */
/* -------------------------------------------------------------------------- */

/// A Lis mixin that contains list items
/// of models that uniquify them based
/// on the ID. If id already exist in the
/// list, don't add them.
mixin UniquifyListModel<T extends Model> {
  /// The list view model data that is still in memory.
  Map<String, T> _cache = {};

  /// Get the list of data for th list view.
  List<T> get items => _items ?? [];
  List<T> _items = [];

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
    _items.sort(Model.orderByRecent);
  }

  /// Replace the whole data with a new list of items
  /// for the list view
  void replaceItems(List<T> data) {
    if (data == null) return;
    _cache.clear();
    _items.clear();
    addItems(data);
    _items.sort(Model.orderByRecent);
  }
}
