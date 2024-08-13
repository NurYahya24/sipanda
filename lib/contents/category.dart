import 'package:flutter/material.dart';
import 'package:sipanda/pages/manage_account.dart';
import 'package:sipanda/pages/profile_page.dart';
import 'package:sipanda/pages/read_data.dart';
import 'package:sipanda/pages/rekap_data.dart';

class Category {
  String thumbnail;
  String nama;
  String subNama;
  String permission;
  Widget destinationPage;

  Category({
    required this.nama,
    required this.thumbnail,
    required this.subNama,
    required this.permission,
    required this.destinationPage,

  });
}

List<Category> CategoryList = [
  Category(nama: "Data Bayi", thumbnail: "images/Category_1.png", subNama: "Manajemen Data Bayi", permission: "KADER", destinationPage: const Read_Data_Page()),
  Category(nama: "Rekap Data", thumbnail: "images/Category_2.png", subNama: "Lihat Visualisasi Grafik Dan Rekap Data", permission: "KADER", destinationPage: const RekapDataPage()),
  Category(nama: "Akun Kader", thumbnail: "images/Category_3.png", subNama: "Manajemen Akun Kader Posyandu", permission: "Admin", destinationPage: const ManageAccount()),
  Category(nama: "Profil", thumbnail: "images/Category_4.png", subNama: "Manajemen Profil Pribadi", permission: "ALL", destinationPage: const Profile_Page()),
];

