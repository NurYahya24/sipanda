import 'package:flutter/material.dart';
import 'package:sipanda/auth/binding.dart';

class Table_Gizi extends StatefulWidget {
  final String uid;
  const Table_Gizi({super.key, required this.uid});

  @override
  State<Table_Gizi> createState() => _Table_GiziState();
}

class _Table_GiziState extends State<Table_Gizi> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fetchDataGizi(widget.uid), 
      builder: (context, snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.waiting :
            return const Center(
              child: CircularProgressIndicator(),
            );
          default :
            if(snapshot.hasError){
              return const Text(
                "Error saat membaca data..."
              );
            }else{
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: 
                      DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Tanggal\nPemeriksaan'
                              )
                            )
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Umur\nBulan'
                              )
                            )
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'BB\n(Kg)'
                              )
                            )
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'PB\n(Cm)'
                              )
                            )
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'LK\n(Cm)'
                              )
                            )
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Ket'
                              )
                            )
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Aksi'
                              )
                            )
                          ),
                        ], 
                        rows: <DataRow>[  
                          for(int i = 0; i < snapshot.data!.docs.length; i++)
                          DataRow(
                            cells: <DataCell>[
                              DataCell(snapshot.data!.docs[i]['periksa']?Text(snapshot.data!.docs[i]['tgl-periksa'].toString()): const Text('-')),
                              DataCell(Text('${snapshot.data!.docs[i]['bulan']} Bulan')),
                              DataCell(snapshot.data!.docs[i]['periksa']?Text('${snapshot.data!.docs[i]['BB']} Kg'): const Text('-')),
                              DataCell(snapshot.data!.docs[i]['periksa']?Text('${snapshot.data!.docs[i]['TB']} Cm'): const Text('-')),
                              DataCell(snapshot.data!.docs[i]['periksa']?Text("${snapshot.data!.docs[i]['LK']} Cm"): const Text('-')),
                              const DataCell(Text('N/B')),
                              DataCell(ElevatedButton(
                                onPressed: (){
                                  
                                },
                                child: snapshot.data!.docs[i]['periksa'] ? const Text('Edit') : const Text('Tambah'),))
                          ]
                        )
                      ]
                    )
                )
            );
          }
        }
      }
    );
  }
}