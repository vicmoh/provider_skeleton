/// This class is the foundation used to extends
/// and the generic model where data is being used
/// for the [ListViewLogic].
abstract class Model with CacheSystem {
  /// Get unique id for dummy model.
  /// For each call, id will increment.
  String get uniqueIdForDummy => 'uniqueIdForDummy${++_uniqueIdForDummy}';
  static int _uniqueIdForDummy = 0;

  /// Abstract model that define the model this initialize
  /// the caching system. For every extend of this class
  /// it will add to the cache bucket when instantiating.
  Model() {
    this.addToCache(this);
  }

  /// Create a model from JSON map.
  Model.fromJson(Map json) {
    this.addToCache(this);
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
  /// it will not overwrite. You can do [super.id] or [setId]
  /// which is the exact same thing.
  set id(String val) {
    assert(_id == null);
    if (_id != null) return;
    _id = val;
  }

  /// This id can only be set once, if id already exist
  /// it will not overwrite. You can do [super.id] or [setId]
  /// which is the exact same thing.
  void setId(String val) => this.id = val;

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
  set timestamp(DateTime val) {
    assert(_timestamp == null);
    if (_timestamp != null) return;
    _timestamp = val;
  }

  /// Set the timestamp of when the model was created.
  /// You can only set the timestamp model once.
  /// You can do [setTimestamp] or [timestamp] which
  /// is the exact same thing.
  void setTimestamp(DateTime val) => this.timestamp = val;

  /* --------------------------------- Others --------------------------------- */

  /// Compare model based on timestamp which
  /// will order the list by recent timestamp.
  static int orderByRecent(Model a, Model b) =>
      a == null || b == null ? 0 : b.timestamp.compareTo(a.timestamp);

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
  /// an ID with [setId] parameter, this will
  /// call [setId] function.
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
