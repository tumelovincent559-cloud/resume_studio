
import 'package:flutter/material.dart';
import '../../models/resume.dart';
import '../widgets/template_card.dart';
import 'resume_editor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resume Studio')),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () async {
              final r = Resume();
              Navigator.push(context, MaterialPageRoute(builder: (_) => ResumeEditor(resume: r)));
            },
            icon: const Icon(Icons.add),
            label: const Text('New Resume'),
          ),
          const SizedBox(height: 20),
          const Text('Templates'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              TemplateCard(id: 'modern', title: 'Modern'),
              TemplateCard(id: 'classic', title: 'Classic'),
              TemplateCard(id: 'minimal', title: 'Minimal'),
            ]),
          ),
        ]),
      ),
    );
  }
}
