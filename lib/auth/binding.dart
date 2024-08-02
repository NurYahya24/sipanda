import 'package:cloud_firestore/cloud_firestore.dart';

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
  for(int i = 0; i < 60 ; i++){
    final data = {
      "periksa" : false,
      "bulan" : i + 1,
      "BB" : 0,
      "TB" : 0,
      "LK" : 0,
      "tgl-periksa" : 0,
    };
    db.collection("bayi").doc(uid).collection("data-gizi").add(data).then((DocumentSnapshot) => print("Berhasil Coy"));
  }
  
}

void addUser(String nama, posyandu, level){
  FirebaseFirestore db = FirebaseFirestore.instance;
  final data = {
    "nama" : nama,
    "posyandu" : posyandu,
    "level" : level
  };

  db.collection("user").add(data).then((DocumentSnapshot) => print("Berhasil Coy"));
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

Stream<QuerySnapshot> fetchDataGizi(String uid){
  FirebaseFirestore db = FirebaseFirestore.instance;
  return db.collection("bayi")
  .doc(uid)
  .collection("data-gizi")
  .orderBy('bulan', descending: false)
  .snapshots();
}




