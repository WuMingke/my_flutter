// 泛型
class TestGeneric {
  void start() {}
}

class Cache<T> {
  final Map<String, T> _cached = {};

  void setItem(String key, T? value) {
    if (value == null) return;
    _cached[key] = value;
  }

  T? getItem(String key) {
    return _cached[key];
  }
}
