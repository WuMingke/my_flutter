import 'package:shared_preferences/shared_preferences.dart';

class ProjectCache {
  SharedPreferences? sp;

  ProjectCache._() {
    _init();
  }
  static late ProjectCache _instance = ProjectCache._();
  factory ProjectCache() => _instance;

  void _init() async {
    sp ??= await SharedPreferences.getInstance();
    print("_init() 执行完了");
  }

  ProjectCache._pre(SharedPreferences this.sp);

  /// 预初始化，防止在使用get时，sp还没有初始化完
  // TODO: 2023/2/7 mingKE 没懂
  // 初始化时机还是有问题。。
  static Future<ProjectCache> preInit() async {
    print("_执行 preInit：${_instance == null}");
    if (_instance == null) {
      var sp = await SharedPreferences.getInstance();
      print("_执行 preInit");
      _instance = ProjectCache._pre(sp);
    }
    return _instance;
  }

  setString(String key, String value) {
    print("_执行 setString");
    sp?.setString(key, value);
  }

  T get<T>(String key) {
    print("_执行 get");
    return sp?.get(key) as T;
  }
}
