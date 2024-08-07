import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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

class _LineChart extends StatelessWidget {
  final bool male;
  final String uid;
  const _LineChart({required this.male, required this.uid});
  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DataPoint>>(
      stream: fetchDataKurva(uid, true), 
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting :
            return const Center(child: CircularProgressIndicator());
          default :
            if(snapshot.hasError){
              return const Text('Error saat membaca data');
            }
            else{
              var dataPoints = snapshot.data!;
              return LineChart(
                male ? sampleData1(dataPoints) : sampleData2(dataPoints),
              );
            }  
        }
      }
    );
  }

  LineChartData sampleData1(List<DataPoint> data) => LineChartData(
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1(data),
        minX: 0,
        maxX: 60,
        maxY: 30,
        minY: 0,
      );

  LineChartData sampleData2(List<DataPoint> data) => LineChartData(
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData2(data),
        minX: 0,
        maxX: 60,
        maxY: 30,
        minY: 0,
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> lineBarsData1(List<DataPoint> data) => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
        lineChartBarData1_4,
        lineChartBarData1_5,
        lineChartBarData1_6,
        lineChartBarData1_7,
        lineChartBarFromDB(data),

      ];
  List<LineChartBarData> lineBarsData2(List<DataPoint> data) => [
        lineChartBarData2_1,
        lineChartBarData2_2,
        lineChartBarData2_3,
        lineChartBarData2_4,
        lineChartBarData2_5,
        lineChartBarData2_6,
        lineChartBarData2_7,
        lineChartBarFromDB(data),

      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 6:
        text = '6';
        break;
      case 12:
        text = '12';
        break;
      case 18:
        text = '18';
        break;
      case 24:
        text = '24';
        break;
      case 30:
        text = '30';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('0', style: style,);
        break;
      case 30:
        text = const Text('30', style: style);
        break;
      case 60:
        text = const Text('60', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 2),
          left: BorderSide(color: Colors.black, width: 2),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 192, 0, 0),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0;i< 61;i++)
          FlSpot(_listMin3SDMale[i].bulan, _listMin3SDMale[i].score),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 255, 0, 0),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0; i < 61 ; i++)
          FlSpot(_listMin2SDMale[i].bulan, _listMin2SDMale[i].score),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 255, 255, 0),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0; i < 61 ; i++)
          FlSpot(_listMin1SDMale[i].bulan, _listMin1SDMale[i].score)
        ],

      );
  LineChartBarData get lineChartBarData1_4 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 146, 208, 80),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0;i< 61;i++)
          FlSpot(_listMedianMale[i].bulan, _listMedianMale[i].score),
        ],
      );
  LineChartBarData get lineChartBarData1_5 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 255, 255, 0),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0;i< 61;i++)
          FlSpot(_listPlus1SDMale[i].bulan, _listPlus1SDMale[i].score),
        ],
      );
  LineChartBarData get lineChartBarData1_6 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 255, 0, 0),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0;i< 61;i++)
          FlSpot(_listPlus2SDMale[i].bulan, _listPlus2SDMale[i].score),
        ],
      );
  LineChartBarData get lineChartBarData1_7 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 192, 0, 0),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0;i< 61;i++)
          FlSpot(_listPlus3SDMale[i].bulan, _listPlus3SDMale[i].score),
        ],
      );
  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 192, 0, 0),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0;i< 61;i++)
          FlSpot(_listMin3SDFemale[i].bulan, _listMin3SDFemale[i].score),
        ],
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 255, 0, 0),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0; i < 61 ; i++)
          FlSpot(_listMin2SDFemale[i].bulan, _listMin2SDFemale[i].score),
        ],
      );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 255, 255, 0),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0; i < 61 ; i++)
          FlSpot(_listMin1SDFemale[i].bulan, _listMin1SDFemale[i].score)
        ],

      );
  LineChartBarData get lineChartBarData2_4 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 146, 208, 80),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0;i< 61;i++)
          FlSpot(_listMedianFemale[i].bulan, _listMedianFemale[i].score),
        ],
      );
  LineChartBarData get lineChartBarData2_5 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 255, 255, 0),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0;i< 61;i++)
          FlSpot(_listPlus1SDFemale[i].bulan, _listPlus1SDFemale[i].score),
        ],
      );
  LineChartBarData get lineChartBarData2_6 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 255, 0, 0),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0;i< 61;i++)
          FlSpot(_listPlus2SDFemale[i].bulan, _listPlus2SDFemale[i].score),
        ],
      );
  LineChartBarData get lineChartBarData2_7 => LineChartBarData(
        isCurved: true,
        preventCurveOverShooting : true,
        preventCurveOvershootingThreshold: 0,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 192, 0, 0),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          for(int i = 0;i< 61;i++)
          FlSpot(_listPlus3SDFemale[i].bulan, _listPlus3SDFemale[i].score),
        ],
      );

  LineChartBarData lineChartBarFromDB(List<DataPoint> data) => LineChartBarData(
        isCurved: false,
        curveSmoothness: 0.0,
        color: const Color.fromARGB(255, 108, 105, 155),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: data
            .map((point) => FlSpot(point.bulan, point.bb))
            .toList(),
      );
}

class KMS extends StatefulWidget {
  final String uid;
  final bool male;
  const KMS({super.key, required this.uid, required this.male});

  @override
  State<StatefulWidget> createState() => KMSState();
}

class KMSState extends State<KMS> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Laki-laki',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 6, left: 6),
                  child: _LineChart(uid: widget.uid, male: widget.male),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}