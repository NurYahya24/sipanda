class Category {
  String thumbnail;
  String nama;
  String subNama;

  Category({
    required this.nama,
    required this.thumbnail,
    required this.subNama,

  });
}

List<Category> CategoryList = [
  Category(nama: "Data Bayi", thumbnail: "images/Category_1.png", subNama: "Manajemen Data Bayi"),
  Category(nama: "Statistik", thumbnail: "images/Category_2.png", subNama: "Lihat Visualisasi Grafik Dalam Rentang Waktu"),
  Category(nama: "Akun Kader", thumbnail: "images/Category_3.png", subNama: "Manajemen Akun Kader Posyandu"),
  Category(nama: "Profil", thumbnail: "images/Category_4.png", subNama: "Manajemen Profil Pribadi")
];

