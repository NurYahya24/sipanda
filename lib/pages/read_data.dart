import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sipanda/pages/add_data.dart';
import 'package:sipanda/pages/list_data.dart';

class Read_Data_Page extends StatefulWidget {
  const Read_Data_Page({super.key});

  @override
  State<Read_Data_Page> createState() => _Read_Data_PageState();
}

class _Read_Data_PageState extends State<Read_Data_Page> {
  TextEditingController searchController = TextEditingController();
  int selectIndex = 0;
  String searchQuery = ""; 

  void updateSearchQuery(String query){
    setState(() {
      searchQuery = query;
    });

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Data Bayi", style: Theme.of(context).textTheme.titleLarge, ),
            backgroundColor: const Color(0xFF4D80DF),
            iconTheme: const IconThemeData(color: Colors.white,),
            elevation: 0.0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Padding
              (padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 45,
                child: TextField(
                  onTapOutside: (event){
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      prefixIcon: const Icon(Icons.search_outlined),
                      hintText: 'Cari Nama Bayi',
                      fillColor: const Color.fromARGB(255, 154, 199, 236),
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                    onChanged: updateSearchQuery,
                ),
              ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color:  const Color.fromARGB(255, 154, 199, 236),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 6),
                        child: TabBar(
                          onTap: (index) {
                            setState(() {
                              selectIndex = index;
                            });
                          },
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 05),
                          indicatorColor: Colors.white,
                          tabs: [
                            selectIndex != 0
                                ? const Text(
                                    'Semua',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
                                  )
                                : Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: const Color(0xffe9e9e9)),
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Semua',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ),
                                  ),
                            selectIndex != 1
                                ? const Text(
                                    'Anggrek',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
                                  )
                                : Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: const Color(0xffe9e9e9)),
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Anggrek',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ),
                                  ),
                            selectIndex != 2
                                ? const Text(
                                    'Cempaka',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
                                  )
                                : Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      // color: const Color(0xffe9e9e9)),
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Cempaka',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                     Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          List_Data_Page(
                            searchQuery: searchQuery,
                            filter: 'Semua',
                          ),
                          List_Data_Page(
                            searchQuery: searchQuery,
                            filter: 'Anggrek',
                          ),
                          List_Data_Page(
                            searchQuery: searchQuery,
                            filter: 'Cempaka',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Tambah Data Bayi',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InputDataPage()),
          );
        },
        backgroundColor: const Color(0xFF4D80DF),
        label: const Text(
          'Tambah Data',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.w500,
            ),
        ),
        icon: Icon(Icons.add, color: Colors.white,size: 25,),
      ),)
      )
    );
  }
}