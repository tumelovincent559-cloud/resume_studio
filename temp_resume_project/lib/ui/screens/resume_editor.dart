
import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/resume.dart';
import '../../services/pdf_engine.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:printing/printing.dart';

class ResumeEditor extends StatefulWidget {
  final Resume resume;
  const ResumeEditor({required this.resume, super.key});
  @override
  State<ResumeEditor> createState() => _ResumeEditorState();
}

class _ResumeEditorState extends State<ResumeEditor> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _summaryCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameCtrl.text = widget.resume.fullName;
    _emailCtrl.text = widget.resume.email;
    _phoneCtrl.text = widget.resume.phone;
    _summaryCtrl.text = widget.resume.summary;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final x = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (x == null) return;
    final cropped = await ImageCropper().cropImage(sourcePath: x.path, compressQuality: 85, uiSettings: [
      AndroidUiSettings(toolbarTitle: 'Crop Photo'),
      IOSUiSettings(title: 'Crop Photo')
    ]);
    if (cropped == null) return;
    setState(() {
      widget.resume.photoPath = cropped.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () async {
            widget.resume.fullName = _nameCtrl.text;
            widget.resume.email = _emailCtrl.text;
            widget.resume.phone = _phoneCtrl.text;
            widget.resume.summary = _summaryCtrl.text;
            final bytes = await PdfEngine.buildPdf(widget.resume);
            await Printing.sharePdf(bytes: bytes, filename: '\${widget.resume.fullName}_resume.pdf');
          },
        )
      ]),
      body: ListView(padding: const EdgeInsets.all(12), children: [
        Row(children: [
          GestureDetector(
            onTap: pickImage,
            child: CircleAvatar(radius: 36, backgroundImage: widget.resume.photoPath.isNotEmpty ? FileImage(File(widget.resume.photoPath)) : null, child: widget.resume.photoPath.isEmpty ? const Icon(Icons.camera_alt) : null),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(children: [
            TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Full name')),
            TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: 'Phone')),
          ])),
        ]),
        const SizedBox(height: 12),
        TextField(controller: _summaryCtrl, decoration: const InputDecoration(labelText: 'Professional summary'), maxLines: 4),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: () async {
          widget.resume.fullName = _nameCtrl.text;
          widget.resume.email = _emailCtrl.text;
          widget.resume.phone = _phoneCtrl.text;
          widget.resume.summary = _summaryCtrl.text;
          Navigator.pop(context);
        }, child: const Text('Save')),
      ]),
    );
  }
}
