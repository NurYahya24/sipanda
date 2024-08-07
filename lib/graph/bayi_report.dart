import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sipanda/auth/binding.dart';
import 'package:sipanda/contents/BBlist.dart';


Future<Uint8List> generateReport(var data, String gender) async {
  const tableHeaders = ['Tanggal Pemeriksaan', 'Umur (Bulan)', 'BB (Kg)', 'PB/TB (Cm)', 'LK (Cm)', 'KET'];

  const baseColor = PdfColors.cyan;

  final document = pw.Document();

  final tema = pw.ThemeData.withFont(
    base: await PdfGoogleFonts.openSansRegular(),
    bold: await PdfGoogleFonts.openSansBold(),
  );

  final table = pw.TableHelper.fromTextArray(
    border: pw.TableBorder.all(width: 1),
    headers: tableHeaders,
    data: List<List<dynamic>>.generate(
      data.length,
      (index) => <dynamic>[
        getDate(data[index]['tgl-periksa']),
        data[index]['bulan'],
        data[index]['BB'],
        data[index]['TB'],
        data[index]['LK'],
        data[index]['bulan'] == 0 ? ' ' :
        generateKeterangan(
          data[index]['BB'].toDouble(), 
          data[index-1]['BB'].toDouble(), 
          data[index]['bulan'],
          gender == 'Laki-laki' ? true : false,
          !(data[index-1]['periksa'])
        ),
      ],
    ),
    headerStyle: pw.TextStyle(
      color: PdfColors.white,
      fontWeight: pw.FontWeight.bold,
    ),
    headerDecoration: const pw.BoxDecoration(
      color: baseColor,
    ),
    rowDecoration: const pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(
          color: baseColor,
          width: .5,
        ),
      ),
    ),
    cellAlignment: pw.Alignment.centerRight,
    cellAlignments: {0: pw.Alignment.centerLeft},
  );

  

  final header = pw.Column(
    children: [
      pw.Text('DATA PELAPORAN GIZI POSYANDU SELERONG',
          style: const pw.TextStyle(
            color: PdfColors.black,
            fontSize: 16,
          )),
      pw.Divider(thickness: 3),
    ]
  );

  final List<pw.Widget>  _table = [
    header,
    table
  ];

  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      theme: tema,
      build: (context) => _table
    )
  );

  

  return document.save();
}