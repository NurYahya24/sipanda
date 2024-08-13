import 'package:cloud_firestore/cloud_firestore.dart';
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


Future<Uint8List> generateReport(String gender, String uid) async {
  const tableHeaders = ['Tanggal Pemeriksaan', 'Umur (Bulan)', 'BB (Kg)', 'PB/TB (Cm)', 'LK (Cm)', 'KET'];

  const baseColor = PdfColors.cyan;

  final document = pw.Document();

  DocumentSnapshot ingfo = await getIdentity(uid);
  Map<String, dynamic> dataIngfo = ingfo.data() as Map<String, dynamic>;
  QuerySnapshot periksa = await getDataGizi(uid, false);
  QuerySnapshot semua = await getDataGizi(uid, true);
  var data = periksa.docs;
  var dataSemua = semua.docs;
  final tema = pw.ThemeData.withFont(
    base: await PdfGoogleFonts.openSansRegular(),
    bold: await PdfGoogleFonts.openSansBold(),
  );

  final ByteData image = await rootBundle.load('images/logo.png');
  final ByteData image2 = await rootBundle.load('images/logo2.png');
  Uint8List logo1 = (image).buffer.asUint8List();
  Uint8List logo2 = (image2).buffer.asUint8List();

  final kmsLaki = pw.Chart(
    grid: pw.CartesianGrid(
      xAxis: pw.FixedAxis([0, 15, 30, 45, 60]),
      yAxis: pw.FixedAxis(
        [0, 5, 10, 15, 20, 25, 30, 35],
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
          dataSemua[data[index]['bulan']]['BB'].toDouble(), 
          dataSemua[(data[index]['bulan']) - 1]['BB'].toDouble(), 
          data[index]['bulan'],
          gender == 'Laki-laki' ? true : false,
          !(dataSemua[(data[index]['bulan']) - 1]['periksa'])
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

  final identitas = pw.Padding(
  padding: const pw.EdgeInsets.all(10),
  child: pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
    children: [
      pw.Table(
        children: [
          pw.TableRow(children: [
            pw.Text("Posyandu"),
            pw.Text(" : "),
            pw.Text(dataIngfo['posyandu'].toString()),
          ]),
          pw.TableRow(children: [
            pw.Text("Nama"),
            pw.Text(" : "),
            pw.Text(dataIngfo['nama'].toString()),
          ]),
          pw.TableRow(children: [
            pw.Text("Nama Bapak/Ibu"),
            pw.Text(" : "),
            pw.Text(dataIngfo['ortu'].toString()),
          ]),
          pw.TableRow(children: [
            pw.Text("Alamat"),
            pw.Text(" : "),
            pw.Text(dataIngfo['alamat'].toString()),
          ]),
        ],
      ),
      pw.Table(
        children: [
          pw.TableRow(children: [
            pw.Text("Anak Ke-"),
            pw.Text(" : "),
            pw.Text(dataIngfo['anak'].toString()),
          ]),
          pw.TableRow(children: [
            pw.Text("TTL"),
            pw.Text(" : "),
            pw.Text(getDate(dataIngfo['tgl-lahir'])),
          ]),
          pw.TableRow(children: [
            pw.Text("BB LAHIR"),
            pw.Text(" : "),
            pw.Text(dataIngfo['bbl'].toString()),
          ]),
          pw.TableRow(children: [
            pw.Text("PB LAHIR"),
            pw.Text(" : "),
            pw.Text(dataIngfo['pbl'].toString()),
          ]),
        ],
      ),
    ]
  )
  
);
  
  

  final header = pw.Column(
    children: [
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Container(
            width: 50,
            height: 50,
            child: pw.Image(pw.MemoryImage(logo1))
          ),
          pw.Text('DATA PELAPORAN GIZI POSYANDU SELERONG',
          style: const pw.TextStyle(
            color: PdfColors.black,
            fontSize: 16,
          )),
          pw.Container(
            width: 50,
            height: 50,
            child: pw.Image(pw.MemoryImage(logo2))
          ),
        ]
      ),
      pw.Divider(thickness: 3),
    ]
  );

  final List<pw.Widget>  _table = [
    header,
    identitas,
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
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  width: 50,
                  height: 50,
                  child: pw.Image(pw.MemoryImage(logo1))
                ),
                pw.Column(
                  children: [
                    pw.Text('KARTU MENUJU SEHAT',
                      style: const pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 24,
                      )
                    ),
                    pw.Text('Timbanglah Anak Anda Setiap Bulan',
                      style: const pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                      )
                    ),
                    pw.Text('Anak Sehat, Tambah Umur, Tambah Berat, Tambah Pandai',
                      style: const pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 12,
                      )
                    ),
                  ]
                ),  
                pw.Container(
                  width: 50,
                  height: 50,
                  child: pw.Image(pw.MemoryImage(logo2))
                ),
              ]
            ),
            pw.Divider(thickness: 4),
            pw.SizedBox(height: 10),
            pw.Expanded(
              flex: 2, 
              child: gender == 'Laki-laki' ? kmsLaki : kmsPerempuan),
            pw.Text(
              '*Kurva Ini Dibuat Berdasarkan Permenkes No. 2 Tahun 2020\nTentang Standar Antropometri Anak',
              style: const pw.TextStyle(
                        color: PdfColors.red,
                        fontSize: 8,
                      ),
              textAlign: pw.TextAlign.center
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(0),
                    height: 100,
                    width: 200,
                    decoration: const pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.all(pw.Radius.circular(10)),
                      color: PdfColors.pink50
                      ),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Container(
                          height: 20,
                          width: 200,
                          decoration: const pw.BoxDecoration(
                            borderRadius: pw.BorderRadius.all(pw.Radius.circular(5)),
                            color: PdfColors.red
                            ),
                          child: pw.Center(child: pw.Text('NAIK (T)', style: const pw.TextStyle(color: PdfColors.white))),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            'Grafik BB/U mengikuti garis pertumbuhan atau Kenaikan BB sama dengan KBM (Kenaikan Berat Badan Minimal) atau lebih',
                            style: const pw.TextStyle(color: PdfColors.red),
                            textAlign: pw.TextAlign.center
                          )
                        )
                      ]),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(0),
                    height: 100,
                    width: 200,
                    decoration: const pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.all(pw.Radius.circular(10)),
                      color: PdfColors.pink50
                      ),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Container(
                          height: 20,
                          width: 200,
                          decoration: const pw.BoxDecoration(
                            borderRadius: pw.BorderRadius.all(pw.Radius.circular(5)),
                            color: PdfColors.red
                            ),
                          child: pw.Center(child: pw.Text('TIDAK NAIK (T)', style: const pw.TextStyle(color: PdfColors.white))),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            'Grafik BB/U mendatar atau menurun memotong garis pertumbuhan dibawahnya atau Kenaikan BB kurang dari KBM',
                            style: const pw.TextStyle(color: PdfColors.red),
                            textAlign: pw.TextAlign.center
                          )
                        )
                      ]),
                  ),
                ]
              )
            )
          ]
        );
      }
    )
  );

  

  return document.save();
}