
import 'package:flutter/material.dart';

class TemplateCard extends StatelessWidget {
  final String id;
  final String title;
  const TemplateCard({required this.id, required this.title, super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: SizedBox(width: 140, height: 180, child: Center(child: Text(title))),
    );
  }
}
