import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sipanda/auth/binding.dart';
import 'package:sipanda/pages/table_gizi.dart';

class detailed_data_page extends StatefulWidget {
  final String uid;
  const detailed_data_page({super.key, required this.uid});

  @override
  State<detailed_data_page> createState() => _detailed_data_pageState();
}
class _detailed_data_pageState extends State<detailed_data_page> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4D80DF),
          iconTheme: const IconThemeData(color: Colors.white,),
          elevation: 0.0,),
        body: Column(
          children: [
            Header(),
            Expanded(child: Content(uid: widget.uid)),
          ],
        ),
      ),);
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)
        ),
      gradient: LinearGradient(
        colors: [Color(0xFF4D80DF), Color.fromRGBO(142, 176, 240, 1)],
        begin: Alignment.center,
        end: FractionalOffset.bottomCenter)
      ),
    );
  }
}

class Content extends StatefulWidget {
  final String uid;
  const Content({super.key, required this.uid});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  int _index = 0;
  final List<String> _title = [
    'Informasi Data Bayi',
    'Laporan Gizi',
    'Kartu Menuju Sehat',
  ];
  late final List<Widget> _pages;
  void _linkedList(bool next){
    setState((){
      if(next){
        if(_index ==2){
          return;
        }else{
          _index++;
        }
      }else{
        if(_index == 0){
          return;
        }else{
          _index--;
        }
      }
    });
  }
  @override
  void initState() {
     super.initState();
    _pages = [
      informasi(uid: widget.uid),
      Table_Gizi(uid: widget.uid),
      informasi(uid: widget.uid),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        left: 24,
        right: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                _linkedList(false);
              }, icon: const Icon(Icons.navigate_before_rounded)),
              Text(
                _title.elementAt(_index),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(onPressed: (){
                _linkedList(true);
              }, icon: const Icon(Icons.navigate_next_rounded)),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: 
            _pages.elementAt(_index),
          )
        ],
      ),
    );
  }
}


Widget listProfile(IconData icon, String title, String value, BuildContext context){
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20,
        ),
        const SizedBox(width: 24,), 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodySmall),
            Text(value, overflow: TextOverflow.ellipsis,)            
          ],
        )
      ],
    ),
  );
}

class informasi extends StatefulWidget {
  final String uid;
  const informasi({super.key, required this.uid});

  @override
  State<informasi> createState() => _informasiState();
}

class _informasiState extends State<informasi> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fetchInfo(widget.uid), 
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default :
            if(snapshot.hasError){
              return const Text("Error saat membaca data...");
            }else{
              final Timestamp timestamp = snapshot.data?['tgl-lahir'] as Timestamp;
              final DateTime dateTime = timestamp.toDate();
              var formatTanggal ="${dateTime.day}-${dateTime.month}-${dateTime.year}";
              var data = snapshot.data!;
              return ListView(
                children: [
                  listProfile(Icons.calendar_today, 'Tanggal Lahir', formatTanggal, context),
                  listProfile(Icons.family_restroom, 'Nama Ibu/Bapak', data['ortu'], context),
                  listProfile(Icons.location_pin, 'Alamat', data['alamat'], context),
                  listProfile(data['jenkel'] == 'Laki-laki'? Icons.male : Icons.female, 'Jenis Kelamin', data['jenkel'], context),
                  listProfile(Icons.monitor_weight_outlined, 'BB Lahir', '${data['bbl']} Kg', context),
                  listProfile(Icons.straighten, 'PB Lahir', '${data['pbl']} Cm', context),
                  listProfile(Icons.face, 'LK Lahir', "${data['lkl']} Cm", context),
                ],
              );
            }
        }
      }
    );
  }
}