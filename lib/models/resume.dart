
import 'package:uuid/uuid.dart';

class Resume {
  String id;
  String fullName;
  String email;
  String phone;
  String summary;
  List<Map<String, String>> experience;
  List<String> skills;
  String photoPath;
  String templateId;

  Resume({
    String? id,
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.summary = '',
    this.experience = const [],
    this.skills = const [],
    this.photoPath = '',
    this.templateId = 'modern',
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'email': email,
    'phone': phone,
    'summary': summary,
    'experience': experience,
    'skills': skills,
    'photoPath': photoPath,
    'templateId': templateId,
  };

  static Resume fromJson(Map<String, dynamic> j) => Resume(
    id: j['id'] ?? '',
    fullName: j['fullName'] ?? '',
    email: j['email'] ?? '',
    phone: j['phone'] ?? '',
    summary: j['summary'] ?? '',
    experience: List<Map<String,String>>.from(j['experience'] ?? []),
    skills: List<String>.from(j['skills'] ?? []),
    photoPath: j['photoPath'] ?? '',
    templateId: j['templateId'] ?? 'modern',
  );
}
