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
    db.collection("bayi").doc(uid).collection("data-gizi").add(data).then((DocumentSnapshot) => print("Berhasil Coy"));
  }
  
}

// void addUser(String nama, posyandu, level){
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   final data = {
//     "nama" : nama,
//     "posyandu" : posyandu,
//     "level" : level,
//     "avatar" : 0
//   };

//   db.collection("user").add(data).then((DocumentSnapshot) => print("Berhasil Coy"));
// }

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

Stream<QuerySnapshot> fetchDataGizi(String uid){
  FirebaseFirestore db = FirebaseFirestore.instance;
  return db.collection("bayi")
  .doc(uid)
  .collection("data-gizi")
  .orderBy('bulan', descending: false)
  .snapshots();
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
    .update(data)
    .then((DocumentSnapshot) => print("Berhasil Coy Update"));
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
    .update(data)
    .then((DocumentSnapshot) => print("Berhasil Coy Delete"));
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



