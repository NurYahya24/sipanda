import 'package:flutter/material.dart';
import 'package:sipanda/pages/list_rekap.dart';

class RekapDataPage extends StatefulWidget {
  const RekapDataPage({super.key});

  @override
  State<RekapDataPage> createState() => _RekapDataPageState();
}

class _RekapDataPageState extends State<RekapDataPage> {
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Rekap Data", style: Theme.of(context).textTheme.titleLarge, ),
            backgroundColor: const Color(0xFF4D80DF),
            iconTheme: const IconThemeData(color: Colors.white,),
            elevation: 0.0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
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
                     const Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          RekapDetailed(
                            filter: 'Semua',
                          ),
                          RekapDetailed(
                            filter: 'Anggrek',
                          ),
                          RekapDetailed(
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
          floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context, 
                    //   MaterialPageRoute(
                    //     builder: (context) => PdfViewer(uid : widget.uid, gender: widget.gender)
                    //   )
                    // );
                  },
                  backgroundColor: const Color(0xFF4D80DF),
                  tooltip: 'Print',
                  child : const Icon(Icons.print, color: Colors.white,),
                  ),
        )
      )
    );
  }
}