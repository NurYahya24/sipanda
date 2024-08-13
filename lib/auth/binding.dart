import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Stream<QuerySnapshot> whoAmI() {
    return FirebaseFirestore.instance.collection('user').snapshots();
}

void addBayi(String posyandu, String nama, String alamat, DateTime tgl, String jenkel, double bbl, double pbl, double lkl, double anak, String ortu){
  FirebaseFirestore db = FirebaseFirestore.instance;
  final data = {
    "posyandu" : posyandu,
    "nama" : nama,
    "alamat" : alamat,
    "tgl-lahir" : tgl,
    "jenkel" : jenkel,
    "bbl" : bbl,
    "pbl" : pbl,
    "lkl" : lkl,
    "anak" : anak,
    "ortu" : ortu
  };

  db.collection("bayi").add(data).then((DocumentSnapshot) => loopDataGizi(DocumentSnapshot.id));
}

void loopDataGizi(String uid){
  FirebaseFirestore db = FirebaseFirestore.instance;
  for(int i = 0; i < 61 ; i++){
    final data = {
      "periksa" : false,
      "bulan" : i,
      "BB" : 0,
      "TB" : 0,
      "LK" : 0,
      "tgl-periksa" : Timestamp.now(),
    };
    db.collection("bayi").doc(uid).collection("data-gizi").add(data);
  }
  
}

void switchUser(String uid, bool aktif, bool admin){
  String level = aktif ? "Kader" : "Nonaktif";
  level = admin? "Admin" : level;
  FirebaseFirestore db = FirebaseFirestore.instance;
  var data = {
    "level" : level
  };
  db.collection("user")
    .doc(uid)
    .update(data);
}

Stream<QuerySnapshot> readUser(String filter){
  FirebaseFirestore db = FirebaseFirestore.instance;
  if(filter == 'Semua'){
    return db.collection('user')
            .orderBy('nama', descending: false)
            .snapshots();
  }else{
    return db.collection('user')
            .where('level', isEqualTo: filter)
            .orderBy('nama', descending: false)
            .snapshots();
  }
}

Stream<QuerySnapshot> readData(String filter, String searchKey) {
  searchKey = searchKey.toUpperCase();
  if(filter == 'Semua'){
    return FirebaseFirestore.instance
        .collection('bayi')
        .where('nama', isGreaterThanOrEqualTo: searchKey)
        .orderBy('tgl-lahir', descending: true)
        .snapshots();
  }else{
    return FirebaseFirestore.instance
        .collection('bayi')
        .where('posyandu', isEqualTo: filter)
        .where('nama', isGreaterThanOrEqualTo: searchKey)
        .orderBy('tgl-lahir', descending: true)
        .snapshots();
  }
  
}

Stream<DocumentSnapshot> fetchInfo(String uid){
  FirebaseFirestore db = FirebaseFirestore.instance;
  return db.collection("bayi")
    .doc(uid)
    .snapshots();
}

Stream<QuerySnapshot> fetchDataGizi(String uid, bool header){
  FirebaseFirestore db = FirebaseFirestore.instance;
  if(header){
    return db.collection("bayi")
    .doc(uid)
    .collection("data-gizi")
    .where('periksa', isEqualTo: true)
    .orderBy('bulan', descending: false)
    .snapshots();
  }else{
    return db.collection("bayi")
    .doc(uid)
    .collection("data-gizi")
    .orderBy('bulan', descending: false)
    .snapshots();
  }
  
}

void CheckUp(DateTime tanggal, double BB, double PB, double LK, String uid, String idCheckup){
  FirebaseFirestore db = FirebaseFirestore.instance;
  final data = {
    'tgl-periksa' : tanggal,
    'BB' : BB,
    'TB' : PB,
    'LK' : LK,
    'periksa' : true
  };
  db.collection("bayi")
    .doc(uid)
    .collection("data-gizi")
    .doc(idCheckup)
    .update(data);
}

delCheckUp(String uid, String idCheckUp){
  FirebaseFirestore db = FirebaseFirestore.instance;
  final data = {
    'tgl-periksa' : Timestamp.now(),
    'BB' : 0,
    'TB' : 0,
    'LK' : 0,
    'periksa' : false
  };
  db.collection("bayi")
    .doc(uid)
    .collection("data-gizi")
    .doc(idCheckUp)
    .update(data);
}

void editProfile(String nama, int avatar, String posyandu){
  var uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final data = {
    "avatar" : avatar,
    "nama" : nama,
    "posyandu" : posyandu,
  };
  db.collection("user")
    .doc(uid)
    .update(data);
}

class DataPoint {
  final double bulan;
  final double bb;

  DataPoint({required this.bulan, required this.bb});

 factory DataPoint.fromMap(Map<String, dynamic> map) {
    return DataPoint(
      bulan :(map['bulan'] as num).toDouble(),
      bb : (map['BB'] as num).toDouble(),
    );
  }
}

Stream<List<DataPoint>> fetchDataKurva(String uid, bool isMale) {
  return FirebaseFirestore.instance
      .collection('bayi')
      .doc(uid)
      .collection('data-gizi')
      .where('periksa', isEqualTo: true)
      .orderBy('bulan', descending: false)
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      return DataPoint.fromMap(doc.data());
    }).toList();
  });
}

String getDate(Timestamp tgl){
    final DateTime dateTime = tgl.toDate();
    var formatTanggal ="${dateTime.day}-${dateTime.month}-${dateTime.year}";
    return formatTanggal;
  }

void delData(String uid){
  FirebaseFirestore db = FirebaseFirestore.instance;
  db.collection('bayi')
    .doc(uid)
    .delete();
}

void updateBayi(String posyandu, String nama, String alamat, DateTime tgl, String jenkel, double bbl, double pbl, double lkl, double anak, String ortu, String uid){
  FirebaseFirestore db = FirebaseFirestore.instance;
  final data = {
    "posyandu" : posyandu,
    "nama" : nama,
    "alamat" : alamat,
    "tgl-lahir" : tgl,
    "jenkel" : jenkel,
    "bbl" : bbl,
    "pbl" : pbl,
    "lkl" : lkl,
    "anak" : anak,
    "ortu" : ortu
  };

  db.collection('bayi')
    .doc(uid)
    .update(data);
}

Future <DocumentSnapshot> getIdentity(String uid){
  FirebaseFirestore db = FirebaseFirestore.instance;
  var data = db.collection('bayi').doc(uid).get();
  return data;
}

Future <QuerySnapshot> getDataGizi(String uid, bool everything){
  FirebaseFirestore db = FirebaseFirestore.instance;
  if(everything){
    return db.collection('bayi').doc(uid).collection('data-gizi').orderBy('bulan', descending: false).get();
  }else{
    return db.collection('bayi').doc(uid).collection('data-gizi').where('periksa', isEqualTo: true).orderBy('bulan', descending: false).get();
  }
}


