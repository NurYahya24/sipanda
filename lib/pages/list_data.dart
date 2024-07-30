import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sipanda/auth/binding.dart';

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
        stream: readData(widget.filter),
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if(snapshot.hasError){
              return Text(
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
                return Text('aaa');
              }
            }
          }
        },),
    );
  }
}