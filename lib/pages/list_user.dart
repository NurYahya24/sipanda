import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipanda/auth/binding.dart';

class List_User_Page extends StatefulWidget {
  final String filter;
  const List_User_Page({super.key, required this.filter});

  @override
  State<List_User_Page> createState() => _List_User_PageState();
}

class _List_User_PageState extends State<List_User_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          children: <Widget>[
            StreamBuilder(
              stream: readUser(widget.filter), 
              builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.waiting :
                    return const Center(child: CircularProgressIndicator());
                  default :
                    if(snapshot.hasError){
                      return const Text("Error saat membaca data...");
                    }else{
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
                                    child: const Icon(Icons.warning_rounded, size: 45),
                                  ),
                                  title: const Text(
                                    'Belum Ada Akun',
                                  ),
                                  subtitle: const Text(
                                    'Data Akun Tidak Ditemukan'
                                  ),
                                )
                              ],
                            ),
                          )
                        );
                      }else{
                        var data = snapshot.data!.docs;
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index){
                            final docID = data[index].id;
                            return Card(
                              elevation: 8,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: data[index]['level'] == 'Admin' ? [const Color.fromRGBO(245, 189, 2, 1), const Color.fromARGB(255, 238, 205, 98)] : 
                                    [const Color(0xFF4D80DF), const Color.fromRGBO(142, 176, 240, 1)],
                                    begin: Alignment.centerLeft,
                                    end: FractionalOffset.centerRight
                                  )                   
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10,
                                  ),
                                  leading: Container(
                                    padding: const EdgeInsets.only(right: 8),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          width: 1,
                                          color: Color.fromARGB(160, 255, 255, 255)
                                        )
                                      )
                                    ),
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: Image.asset("images/avatar${data[index]['avatar']}.png").image,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    data[index]['nama'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: data[index]['level'] == 'Admin' ? 
                                    Text(
                                      data[index]['level'],
                                      style: const TextStyle(color: Colors.white)
                                      ) : 
                                    Text(
                                      "Posyandu : ${data[index]['posyandu']}",
                                      style: const TextStyle(color: Colors.white)
                                  ),
                                  trailing: Visibility(
                                      visible: data[index]['level'] == 'Admin' ? false : true,
                                      child: Switch(
                                      value: data[index]['level'] == 'Nonaktif' ? false : true, 
                                      onChanged: (bool value){
                                        switchUser(docID, value, false);
                                      },
                                      activeColor: Colors.white,
                                      activeTrackColor: const Color.fromRGBO(224, 46, 129, 1),
                                      inactiveThumbColor: Colors.white,
                                      inactiveTrackColor: Colors.grey,
                                    )
                                  ), 
                                  onLongPress: (){
                                   showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Konfirmasi'),
                                          content: const Text('Apakah Anda yakin ingin mengubah akun ini menjadi admin?'),
                                          actions: [
                                            TextButton(
                                              child: const Text('Batal', style: TextStyle(color: Color(0xFF4D80DF))),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Ya', style: TextStyle(color: Color(0xFF4D80DF))),
                                              onPressed: () {
                                                switchUser(docID, true, true);
                                                Navigator.of(context).pop();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Akun berhasil diubah menjadi admin.'),
                                                    backgroundColor:Color(0xFF4D80DF),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}