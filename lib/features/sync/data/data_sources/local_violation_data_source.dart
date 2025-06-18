import 'package:hive_flutter/hive_flutter.dart';
import '../models/violation_model.dart';

class LocalViolationDataSource {
  static const _boxName = 'offline_violations';

  Future<void> cacheViolation(ViolationModel v) async {
    final box = await Hive.openBox<ViolationModel>(_boxName);
    await box.put(v.id, v);
    await box.close();
  }

  Future<List<ViolationModel>> fetchAll() async {
    final box = await Hive.openBox<ViolationModel>(_boxName);
    final list = box.values.toList();
    await box.close();
    return list;
  }

  Future<void> clearAll() async {
    final box = await Hive.openBox<ViolationModel>(_boxName);
    await box.clear();
    await box.close();
  }
}
