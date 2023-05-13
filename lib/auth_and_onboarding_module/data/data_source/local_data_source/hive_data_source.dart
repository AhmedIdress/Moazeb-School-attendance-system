import 'package:hive/hive.dart';

class HiveDataSource<T> {
  //static HiveDataSource get instance => HiveDataSource();
  HiveDataSource(String boxName) {
    _box = Hive.box(boxName);
  }

  late Box _box;

  void set(String key, T value) async {
    _box.put(key, value);
  }

  T get(
    String key,
  ) {
    return _box.get(key);
  }
}
