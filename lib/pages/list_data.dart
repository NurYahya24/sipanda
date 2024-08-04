import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sipanda/auth/binding.dart';
import 'package:sipanda/pages/detailed_data.dart';

class List_Data_Page extends StatefulWidget {
  final String searchQuery, filter;
  const List_Data_Page({super.key, required this.searchQuery, required this.filter});

  @override
  State<List_Data_Page> createState() => _List_Data_PageState();
}

class _List_Data_PageState extends State<List_Data_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: readData(widget.filter, widget.searchQuery),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if(snapshot.hasError){
              return const Text(
                'Error saat membaca data'
              );
            }else {
              if(snapshot.data!.docs.length == 0){
                return Center(
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        ListTile(
                          leading: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 100,
                              minHeight: 190,
                              maxWidth: 200,
                              maxHeight: 200,
                            ),
                            child: Icon(Icons.error_outline, size: 45,),
                          ),
                          title: Text(
                            'Belum ada data'
                          ),
                          subtitle: Text(
                            'Silahkan input data'
                            ),
                        )
                      ],
                    ),
                  ),
                );
              }else{
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
                    final Timestamp timestamp = snapshot.data?.docs[index]['tgl-lahir'] as Timestamp;
                    final DateTime dateTime = timestamp.toDate();
                    var formatTanggal ="${dateTime.day}-${dateTime.month}-${dateTime.year}";
                    return InkWell(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 12),
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 216, 174, 255),
                              radius: 50,
                              child: ClipOval(
                                child: snapshot.data!.docs[index]['jenkel'] == 'Laki-laki' ? Image.asset('images/anakM.png',) : Image.asset('images/anakF.png'),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 10
                            ),
                            width: MediaQuery.of(context).size.width * 0.77,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.docs[index]['nama'],
                                  style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  formatTanggal
                                ),
                                Text(
                                  snapshot.data!.docs[index]['ortu']
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          border: Border.all(color: Colors.black)
                                        ),
                                        child: Text(snapshot.data!.docs[index]['alamat']),
                                      ),
                                    ),
                                    
                                    Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 154, 199, 236),
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                          color: const Color.fromARGB(255, 154, 199, 236)
                                        )
                                      ),
                                      child: Text(snapshot.data!.docs[index]['posyandu'],style: const TextStyle(color: Colors.black),),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                const Divider(color: Colors.black,)
                              ],
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => detailed_data_page(uid: snapshot.data!.docs[index].id)
                          )
                        );
                      },
                    );
                  }
                );
              }
            }
          }
        },),
    );
  }
}