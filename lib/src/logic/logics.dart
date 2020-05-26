import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'view_logic.dart';

/// This class is the foundation used to initialize
/// and setup the model which will be provided
/// through the widget tree
class Logics {
  /// Create a store of a logic. Must dispose the store.
  static void createStore(String name, ViewLogic logic) {
    if (_store[name] != null) {
      assert(
          true,
          "The store ($name) already exist. " +
              "Create store that is available instead.");
      disposeStore(name);
    }
    _store[name] = logic;
  }

  /// Get view logic store.
  static ViewLogic getStore(String name) => _store[name];
  static Map<String, ViewLogic> _store = {};

  /// Dispose the logic from store.
  static disposeStore(String name) {
    if (_store[name] != null) {
      _store[name]?.dispose();
      _store[name] = null;
    }
  }

  /// Allows you to register the class type and request it
  // from anywhere where you have access to the container.
  static GetIt get getIt => _getIt;
  static GetIt _getIt = GetIt.instance;

  /// Keep track of the number of init function being invoked.
  static int _numberOfInitCalls = 0;

  /// Get all the providers that is initialized and provide
  /// is used for the [MultiProvider] on the root of the widget.
  static List<SingleChildWidget> get providers => _providers ?? [];
  static List<SingleChildWidget> _providers = [];

  /// Initialize the locator for the [model] types.
  /// All [ViewLogic] are initialize here.
  /// When initializing, the [callbackSetup] is
  /// a callback function for the setup of the model
  /// that will be provided.
  static void init(void Function() callbackSetup) {
    // Make sure that init is called once.
    _numberOfInitCalls++;
    assert(_numberOfInitCalls <= 1 || callbackSetup == null);

    // Init the model...
    if (callbackSetup != null) callbackSetup();
  }

  /// Call this function inside the [callbackSetup]
  /// function that will passed on [init] function.
  /// This will register and create the provider.
  /// Once model are provided. Wrap the [MaterialApp]
  /// with [MultiProvider] and pass in the
  /// getter [providers] of this class.
  /// By default this function is provided in [factory]
  /// methods. If [isSingleton] is set, then all
  /// data is access to the same pointer when is provided.
  static void provide<T extends ViewLogic>(
    T viewLogic, {
    bool isSingleton = false,
  }) {
    if (!isSingleton)
      _getIt.registerSingleton<T>(viewLogic);
    else
      _getIt.registerFactory<T>(() => viewLogic);
    _providers.add(ChangeNotifierProvider<T>.value(value: _getIt<T>()));
  }
}
