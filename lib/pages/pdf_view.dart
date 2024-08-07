import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sipanda/auth/binding.dart';
import 'package:sipanda/graph/bayi_report.dart';

class PdfViewer extends StatefulWidget {
  final String uid;
  final String gender;
  const PdfViewer({super.key, required this.uid, required this.gender});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  PrintingInfo? printingInfo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dokumen Dibagikan'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dokumen Berhasil Disimpan'),
      ),
    );
  }

  Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File('$appDocPath/document.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }
  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;

    final actions = <PdfPreviewAction>[
      PdfPreviewAction(
        icon: const Icon(Icons.save),
        onPressed: _saveAsFile,
      )
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF View'),
      ),
      body: 
      StreamBuilder(
        stream: fetchDataGizi(widget.uid, false), 
        builder: (context, snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.waiting :
              return const Center(child: CircularProgressIndicator());
            default :
              return PdfPreview(
                maxPageWidth: 700,
                build: (format) => generateReport(snapshot.data!.docs, widget.gender),
                actions: actions,
                onPrinted: _showPrintedToast,
                onShared: _showSharedToast,
              );
          }
        }
      )
    );
  }
}