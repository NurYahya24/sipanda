import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
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

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;

    
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF View'),
      ),
      body: PdfPreview(
                maxPageWidth: 700,
                build: (format) => generateReport(widget.gender, widget.uid),
                onPrinted: _showPrintedToast,
                onShared: _showSharedToast,
              )
      // StreamBuilder(
      //   stream: fetchDataGizi(widget.uid, false), 
      //   builder: (context, snapshot){
      //     switch (snapshot.connectionState){
      //       case ConnectionState.waiting :
      //         return const Center(child: CircularProgressIndicator());
      //       default :
      //         return PdfPreview(
      //           maxPageWidth: 700,
      //           build: (format) => generateReport(snapshot.data!.docs, widget.gender, widget.uid),
      //           actions: actions,
      //           onPrinted: _showPrintedToast,
      //           onShared: _showSharedToast,
      //         );
      //     }
      //   }
      // )
    );
  }
}