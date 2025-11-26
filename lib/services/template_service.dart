
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class TemplateService {
  static Future<Map<String, dynamic>> loadJobSummaries() async {
    final s = await rootBundle.loadString('data/job_categories.json');
    return json.decode(s) as Map<String, dynamic>;
  }
}
