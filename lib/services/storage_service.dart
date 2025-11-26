
import 'package:hive/hive.dart';
import '../models/resume.dart';

class StorageService {
  static const String boxName = 'resumesBox';

  Future<void> saveResume(Resume r) async {
    final box = await Hive.openBox(boxName);
    await box.put(r.id, r.toJson());
    await box.close();
  }

  Future<List<Resume>> loadResumes() async {
    final box = await Hive.openBox(boxName);
    final resumes = box.values.map((e) => Resume.fromJson(Map<String,dynamic>.from(e))).toList();
    await box.close();
    return resumes;
  }

  Future<void> deleteResume(String id) async {
    final box = await Hive.openBox(boxName);
    await box.delete(id);
    await box.close();
  }
}
