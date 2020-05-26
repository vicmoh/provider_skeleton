import 'package:meta/meta.dart';

enum ModelType { safe, unsafe }

/// This class is the foundation used to extends
/// and the generic model where data is being used
/// for the [ListViewLogic].
/// Please note that ID and Timestamp must not be null.
abstract class Model {
  ModelType get modelType => _modelType;
  ModelType _modelType = ModelType.safe;

  /// Create a assert message.
  String _assertMessage(String val) =>
      '\n__________________________________________________\n' +
      val +
      '\n__________________________________________________\n';

  /// Get unique id for dummy model.
  /// For each call, id will increment.
  static String get uniqueId => 'uniqueId${++_uniqueId}';
  static int _uniqueId = 0;

  /// Abstract model that define the model this initialize
  /// the caching system. For every extend of this class
  /// it will add to the cache bucket when instantiating.
  /// Please beware that [timestamp] if null, it will
  /// be default time as now, when this object is created.
  Model(String id, {@required DateTime timestamp}) {
    if (timestamp == null)
      throw Exception('One of the model is missing a timestamp. ' +
          'Make sure to initialize on super().');
    _setId(id);
    setTimestamp(timestamp ?? DateTime.now());
  }

  //// Unsafe version of the model, this
  /// model allow ID and timestamp as
  /// null at the start.
  Model.unsafe({String id, DateTime timestamp})
      : _modelType = ModelType.unsafe {
    _setId(id);
    setTimestamp(timestamp);
  }

  /// Create a model from JSON map.
  Model.fromJson(Map<String, dynamic> json, {String id}) {
    _setId(id ?? json['id']);
  }

  /// Create JSON map from this model.
  Map<String, dynamic> toJson() =>
      {id: this.id, 'timestamp': this.timestamp.toIso8601String()};

  /* -------------------------------- Model ID -------------------------------- */

  String _id;

  /// Get the ID of this model.
  String get id {
    if (modelType == ModelType.safe) assert(_id != null);
    return _id;
  }

  /// This id can only be set once, if id already exist
  /// it will not overwrite. You can do [super.id] or [_setId]
  /// which is the exact same thing.
  void _setId(String val) {
    if (modelType == ModelType.safe) {
      assert(
          val != null,
          _assertMessage(
              'One of the model is missing an ID. When extending a model, ' +
                  'initialized ID with super(id: "someUniqueId")'));
      if (val == null)
        throw Exception(
            'One of the model ID is null. ID of model cannot be null.');
    }
    if (_id != null) return;
    _id = val;
  }

  /* -------------------------------- Timestamp ------------------------------- */

  DateTime _timestamp;

  /// Determine if timestamp is null.
  bool get isTimestampExist => _timestamp == null ? false : true;

  /// Timestamp of when the model was create.
  DateTime get timestamp {
    if (modelType == ModelType.safe) assert(_timestamp != null);
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
    if (modelType == ModelType.safe) {
      assert(
          _timestamp == null,
          _assertMessage(
              'The setTimestamp() function should only be called once.'));
      if (_timestamp != null)
        throw Exception('Model timestamp can only be set onces.');
    }
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
