import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

@RoutePage()
class ResumePreviewPage extends StatelessWidget {
  final String pdfUrl;

  const ResumePreviewPage({
    super.key,
    required this.pdfUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Resume'),
      ),
      body: PdfViewer.uri(
        Uri.parse(pdfUrl),
        params: PdfViewerParams(
          maxScale: 5.0,
        ),
      ),
    );
  }
}
