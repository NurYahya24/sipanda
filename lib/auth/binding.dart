import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> whoAmI() {
    return FirebaseFirestore.instance.collection('user').snapshots();
}

void addBayi(String posyandu, String nama, String alamat, String tgl, String jenkel, double bbl, double pbl, double lkl, double anak, String ortu){
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

  db.collection("bayi").add(data).then((DocumentSnapshot) => print("Berhasil coy"));
}


