import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sipanda/pages/login.dart';
import 'package:sipanda/pages/regis.dart';

class Category {
  String thumbnail;
  String nama;
  String subNama;
  String permission;

  Category({
    required this.nama,
    required this.thumbnail,
    required this.subNama,
    required this.permission,
  });
}

List<Category> CategoryList = [
  Category(nama: "Data Bayi", thumbnail: "images/Category_1.png", subNama: "Manajemen Data Bayi", permission: "ALL"),
  Category(nama: "Statistik", thumbnail: "images/Category_2.png", subNama: "Lihat Visualisasi Grafik Dalam Rentang Waktu", permission: "ALL"),
  Category(nama: "Akun Kader", thumbnail: "images/Category_3.png", subNama: "Manajemen Akun Kader Posyandu", permission: "Super-Admin"),
  Category(nama: "Profil", thumbnail: "images/Category_4.png", subNama: "Manajemen Profil Pribadi", permission: "ALL"),
];

