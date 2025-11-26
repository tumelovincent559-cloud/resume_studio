
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import '../models/resume.dart';

class PdfEngine {
  static Future<Uint8List> buildPdf(Resume r) async {
    final pdf = pw.Document();
    final fontRegular = pw.Font.ttf(await rootBundle.load('assets/fonts/Inter-Regular.ttf'));
    final fontBold = pw.Font.ttf(await rootBundle.load('assets/fonts/Inter-Bold.ttf'));

    pdf.addPage(pw.Page(build: (pw.Context ctx) {
      return pw.Container(pw.EdgeInsets.all(24), child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(r.fullName, style: pw.TextStyle(font: fontBold, fontSize: 28)),
          pw.SizedBox(height: 8),
          pw.Text(r.summary, style: pw.TextStyle(font: fontRegular, fontSize: 12)),
          pw.SizedBox(height: 12),
          pw.Text('Experience', style: pw.TextStyle(font: fontBold, fontSize: 16)),
        ]
      ));
    }));

    return pdf.save();
  }
}
