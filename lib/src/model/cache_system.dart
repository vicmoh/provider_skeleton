import './model.dart';

/// Caching system. This code is incomplete.
/// This will be used to cache model
/// in the future.
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
