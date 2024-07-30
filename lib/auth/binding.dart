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

  db.collection("bayi").add(data).then((DocumentSnapshot) => print("Berhasil Coy"));
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

Stream<QuerySnapshot> readData(String filter) {
  if(filter == 'Semua'){
    return FirebaseFirestore.instance
        .collection('bayi')
        .orderBy('tgl-lahir', descending: true)
        .snapshots();
  }else{
    return FirebaseFirestore.instance
        .collection('bayi')
        .where('posyandu', isEqualTo: filter)
        .orderBy('tgl-lahir', descending: true)
        .snapshots();
  }
  
}




