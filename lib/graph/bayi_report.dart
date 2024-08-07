import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sipanda/auth/binding.dart';
import 'package:sipanda/contents/BBlist.dart';

List _listMin3SDMale = BBMale.BBmaleMin3SD;
List _listMin2SDMale = BBMale.BBmaleMin2SD;
List _listMin1SDMale = BBMale.BBmaleMin1SD;
List _listMedianMale = BBMale.BBMaleMedian;
List _listPlus1SDMale = BBMale.BBMalePlus1SD;
List _listPlus2SDMale = BBMale.BBMalePlus2SD;
List _listPlus3SDMale = BBMale.BBMalePlus3SD;
List _listMin3SDFemale = BBFemale.BBFemaleMin3SD;
List _listMin2SDFemale = BBFemale.BBFemaleMin2SD;
List _listMin1SDFemale = BBFemale.BBFemaleMin1SD;
List _listMedianFemale = BBFemale.BBFemaleMedian;
List _listPlus1SDFemale = BBFemale.BBFemalePlus1SD;
List _listPlus2SDFemale = BBFemale.BBFemalePlus2SD;
List _listPlus3SDFemale = BBFemale.BBFemalePlus3SD;


Future<Uint8List> generateReport(var data, String gender) async {
  const tableHeaders = ['Tanggal Pemeriksaan', 'Umur (Bulan)', 'BB (Kg)', 'PB/TB (Cm)', 'LK (Cm)', 'KET'];

  const baseColor = PdfColors.cyan;

  final document = pw.Document();

  final tema = pw.ThemeData.withFont(
    base: await PdfGoogleFonts.ralewayRegular(),
    bold: await PdfGoogleFonts.ralewayBold(),
  );

  final kmsLaki = pw.Chart(
    grid: pw.CartesianGrid(
      xAxis: pw.FixedAxis([0, 15, 30, 45, 60]),
      yAxis: pw.FixedAxis(
        [0, 5, 10, 15, 20, 25, 30],
      ),
    ),
    datasets: [
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#c00000'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listMin3SDMale[i].score as num;
            final h = _listMin3SDMale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#ff0000'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listMin2SDMale[i].score as num;
            final h = _listMin2SDMale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#ffff00'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listMin1SDMale[i].score as num;
            final h = _listMin1SDMale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#92d050'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listMedianMale[i].score as num;
            final h = _listMedianMale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#ffff00'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listPlus1SDMale[i].score as num;
            final h = _listPlus1SDMale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#ff0000'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listPlus2SDMale[i].score as num;
            final h = _listPlus2SDMale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#c00000'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listPlus3SDMale[i].score as num;
            final h = _listPlus3SDMale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: false,
        drawPoints: true,
        color: baseColor,
        data: List<pw.PointChartValue>.generate(
          data.length,
          (i) {
            final v = data[i]['BB'] as num;
            final h = data[i]['bulan'] as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
    ],
  );
  final kmsPerempuan = pw.Chart(
    grid: pw.CartesianGrid(
      xAxis: pw.FixedAxis([0, 15, 30, 45, 60]),
      yAxis: pw.FixedAxis(
        [0, 5, 10, 15, 20, 25, 30],
      ),
    ),
    datasets: [
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#c00000'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listMin3SDFemale[i].score as num;
            final h = _listMin3SDFemale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#ff0000'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listMin2SDFemale[i].score as num;
            final h = _listMin2SDFemale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#ffff00'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listMin1SDFemale[i].score as num;
            final h = _listMin1SDFemale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#92d050'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listMedianFemale[i].score as num;
            final h = _listMedianFemale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#ffff00'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listPlus1SDFemale[i].score as num;
            final h = _listPlus1SDFemale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#ff0000'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listPlus2SDFemale[i].score as num;
            final h = _listPlus2SDFemale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: true,
        drawPoints: false,
        color: PdfColor.fromHex('#c00000'),
        data: List<pw.PointChartValue>.generate(
          61,
          (i) {
            final v = _listPlus3SDFemale[i].score as num;
            final h = _listPlus3SDFemale[i].bulan as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
      pw.LineDataSet(
        drawSurface: false,
        isCurved: false,
        drawPoints: true,
        color: baseColor,
        data: List<pw.PointChartValue>.generate(
          data.length,
          (i) {
            final v = data[i]['BB'] as num;
            final h = data[i]['bulan'] as num;
            return pw.PointChartValue(h.toDouble(), v.toDouble());
          },
        ),
      ),
    ],
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
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('DATA PELAPORAN GIZI POSYANDU SELERONG',
          style: const pw.TextStyle(
            color: PdfColors.black,
            fontSize: 16,
          )),
        ]
      ),
      pw.Divider(thickness: 3),
    ]
  );

  final List<pw.Widget>  _table = [
    header,
    table,
  ];

  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      theme: tema,
      build: (context) => _table
    )
  );
  document.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      theme: tema,
      build: (context) {
        return pw.Column(
          children: [
            pw.Text('KARTU MENUJU SEHAT',
                style: const pw.TextStyle(
                  color: PdfColors.black,
                  fontSize: 24,
                )),
            pw.Divider(thickness: 4),
            pw.Expanded(
              flex: 2, 
              child: gender == 'Laki-laki' ? kmsLaki : kmsPerempuan),
          ]
        );
      }
    )
  );

  

  return document.save();
}