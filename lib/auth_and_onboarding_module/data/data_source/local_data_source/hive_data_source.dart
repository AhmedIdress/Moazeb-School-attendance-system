import 'package:hive/hive.dart';

class HiveDataSource {
  static HiveDataSource get instance => HiveDataSource();
  final Box _box = Hive.box('cacheData');
  /*void init() async {
    await Hive.openBox('cacheData');
  }*/

  void set<T>(String key, T value) async {
    _box.put(key, value);
  }

  dynamic get(
    String key,
  ) {
    return _box.get(key);
  }
}
