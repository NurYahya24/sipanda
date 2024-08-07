import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sipanda/auth/binding.dart';
import 'package:sipanda/pages/KMS.dart';
import 'package:sipanda/pages/pdf_view.dart';
import 'package:sipanda/pages/table_gizi.dart';

class detailed_data_page extends StatefulWidget {
  final String uid;
  final String nama;
  final String gender;
  const detailed_data_page({super.key, required this.uid, required this.nama, required this.gender});

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
          title: Text(widget.nama, style: Theme.of(context).textTheme.titleLarge,),
          backgroundColor: const Color(0xFF4D80DF),
          iconTheme: const IconThemeData(color: Colors.white,),
          elevation: 0.0,
          ),
        body: Column(
          children: [
            Header(uid: widget.uid,),
            Expanded(child: Content(uid: widget.uid, gender: widget.gender,)),
            const SizedBox(height: 40,)
          ],
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => PdfViewer(uid : widget.uid, gender: widget.gender)
            )
          );
        },
        backgroundColor: const Color(0xFF4D80DF),
        tooltip: 'Print',
        child : const Icon(Icons.print, color: Colors.white,),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String uid;
  const Header({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
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
      child:
      StreamBuilder(
        stream: fetchDataGizi(uid, true),
        builder: (context, snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.waiting :
              return const Center(
                child: CircularProgressIndicator(),
              );
            default :
              if(snapshot.hasError){
                return const Center(child: Text('Error saat membaca data..'),);
              }else{
                var data = snapshot.data!.docs;
                var berat = 'N/A';
                var tinggi = 'N/A';
                var kepala = 'N/A';
                final Timestamp timestamp; 
                final DateTime dateTime;
                var formatTanggal = 'Belum ada pemeriksaan';
                if(data.length != 0){
                  berat = data[data.length - 1]['BB'].toString();
                  tinggi = data[data.length - 1]['TB'].toString();
                  kepala = data[data.length - 1]['LK'].toString();
                  timestamp = data[data.length - 1]['tgl-periksa'] as Timestamp;
                  dateTime = timestamp.toDate();
                  formatTanggal = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                }
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Terakhir di update',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const Spacer(),
                        Text(
                          formatTanggal,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.calendar_today, size: 18, color: Colors.white)
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                            height: 130,
                            width: 100,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Colors.white
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 0, left: 0, right: 45),
                                  height: 45,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(25)),
                                    color: Color.fromARGB(255, 211, 211, 211)
                                  ),
                                  child: const Icon(Icons.monitor_weight_outlined, color: Colors.grey, size: 30,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Berat', 
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500, 
                                          fontSize: 14, 
                                          fontFamily: 'Poppins'),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child : Text(
                                            berat,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis)
                                          ),
                                          const Text(
                                            'Kg',)
                                        ],
                                      )
                                    ],
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                            height: 130,
                            width: 100,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Colors.white
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 0, left: 0, right: 45),
                                  height: 45,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(25)),
                                    color: Color.fromARGB(255, 211, 211, 211)
                                  ),
                                  child: const Icon(Icons.straighten, color: Colors.grey, size: 30,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Tinggi', 
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500, 
                                          fontSize: 14, 
                                          fontFamily: 'Poppins'),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child : Text(
                                            tinggi,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis)
                                          ),
                                          const Text(
                                            'Cm',)
                                        ],
                                      )
                                    ],
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
                            height: 130,
                            width: 100,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Colors.white
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 0, left: 0, right: 45),
                                  height: 45,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(25)),
                                    color: Color.fromARGB(255, 211, 211, 211)
                                  ),
                                  child: const Icon(Icons.child_care, color: Colors.grey, size: 30,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'L. Kepala', 
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500, 
                                          fontSize: 14, 
                                          fontFamily: 'Poppins'),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child : Text(
                                            kepala,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis)
                                          ),
                                          const Text(
                                            'Cm',)
                                        ],
                                      )
                                    ],
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }
          }
        },
      ) 
    );
  }
}

class Content extends StatefulWidget {
  final String uid;
  final String gender;
  const Content({super.key, required this.uid, required this.gender});

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
      Table_Gizi(uid: widget.uid, gender: widget.gender),
      KMS(uid: widget.uid, male: true),
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
              Flexible(
                child: Text(
                _title.elementAt(_index),
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
                )
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
            return const Center(child: CircularProgressIndicator());
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
                  listProfile(Icons.format_list_numbered, 'Anak Ke-', data['anak'].toString(), context),
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