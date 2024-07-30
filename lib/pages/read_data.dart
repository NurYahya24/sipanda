import 'package:flutter/material.dart';
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              const Padding
              (padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'User'
              ),
              
              ),
              Padding
              (padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 45,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      prefixIcon: const Icon(Icons.search_outlined),
                      hintText: 'Cari Nama Bayi',
                      fillColor: Colors.white,
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
              SizedBox(height: 20,),
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
        )
      )
    );
  }
}