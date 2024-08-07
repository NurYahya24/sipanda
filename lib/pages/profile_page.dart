import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sipanda/auth/binding.dart';
import 'package:sipanda/pages/login.dart';

int profile_index = 0;

List<String> _avatar = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];

class Profile_Page extends StatefulWidget {
  const Profile_Page({super.key});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {

  renderContainer(Widget child) {
    return SizedBox(height: 90, width: 90, child: Center(child: child));
  }

  void showDialogWithFields(BuildContext context, username) {
    showDialog(
      context: context,
      builder: (BuildContext builder) {
        var nameController = TextEditingController();
        nameController.text = username;
        return AlertDialog(
          title: const Text('Edit Profil'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 226, 226),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _avatar.length,
                            itemBuilder: (BuildContext context, int index) {
                              return renderContainer(SelectableAvatar(
                                url: 'images/avatar${_avatar[index]}.png',
                                index_avatar: index,
                              ));
                            }),
                      ),
                    ]),
                  ),
                ),
                _textField('Masukan Nama Anda', Icons.person, false, false, nameController)
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: Color.fromRGBO(224, 46, 129, 1),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                editProfile(nameController.text, profile_index, 'Cempaka');
                Navigator.pop(context);
              },
              child: const Text(
                'Simpan',
                style: TextStyle(
                  color: Color.fromRGBO(224, 46, 129, 1),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor:const Color(0xFF4D80DF),
        title: Text('Profil', style: Theme.of(context).textTheme.titleLarge),
        elevation: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          StreamBuilder(
            stream: whoAmI(), 
            builder: (context, snapshot){
              switch (snapshot.connectionState){
                case ConnectionState.waiting :
                  return const CircularProgressIndicator();
                default :
                  if(snapshot.hasError){
                    return const Text("Error saat membaca data...");
                  }else{
                    if(snapshot.hasData){
                      int index = 0;
                      int panjang = snapshot.data!.docs.length;
                      for(int i = 0; i < panjang; i++){
                        if(snapshot.data!.docs[i].id == FirebaseAuth.instance.currentUser!.uid){
                          index = i;
                        }
                      }
                      var data = snapshot.data!.docs[index];
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 52,
                            backgroundColor: const Color(0xFF4D80DF),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: Image.asset("images/avatar${data['avatar']}.png").image,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            data['nama'],
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(FirebaseAuth.instance.currentUser!.email.toString()),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4D80DF),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                                )
                              ),
                              onPressed: (){
                                showDialogWithFields(context, data['nama']);
                              }, 
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 18,
                              ), 
                              label: const Text(
                                'Edit Profil',
                                style: TextStyle(color: Colors.white),
                              )
                            ),
                          )
                        ],
                      );
                    }else{
                      return const Text('Data Kosong');
                    }
                  }
              }
            }
          ),
          const SizedBox(height: 35,),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Card(
              elevation: 4,
              shadowColor: Colors.black12,
              child: ListTile(
                leading: const Icon(Icons.mail),
                title: Text('Ganti E-mail', style: Theme.of(context).textTheme.bodyMedium,),
                trailing: const Icon(Icons.chevron_right),
                onTap: (){
                  
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Card(
              elevation: 4,
              shadowColor: Colors.black12,
              child: ListTile(
                leading: const Icon(Icons.key),
                title: Text('Ganti Kata Sandi', style: Theme.of(context).textTheme.bodyMedium,),
                trailing: const Icon(Icons.chevron_right),
                onTap: (){
                  
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Card(
              elevation: 4,
              shadowColor: Colors.black12,
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: Text('Keluar', style: Theme.of(context).textTheme.bodyMedium,),
                trailing: const Icon(Icons.chevron_right),
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Keluar"),
                        content: const Text("Apakah Anda yakin ingin keluar?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Batal", style: TextStyle(color: Color(0xFF4D80DF),),),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Anda telah berhasil logout.'),
                                  backgroundColor:Color(0xFF4D80DF),
                                ),
                              );
                              
                            },
                            child: const Text("Keluar", style: TextStyle(color: Color(0xFF4D80DF),),),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Card(
              color: const Color.fromARGB(255, 252, 172, 167),
              elevation: 4,
              shadowColor: Colors.black12,
              child: ListTile(
                leading: const Icon(Icons.delete_forever_outlined),
                title: Text('Hapus Akun', style: Theme.of(context).textTheme.bodyMedium,),
                trailing: const Icon(Icons.chevron_right),
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Konfirmasi"),
                        content: const Text("Apakah Anda yakin ingin menghapus Akun?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Batal", style: TextStyle(color:Color(0xFF4D80DF)),),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              
                            },
                            child: const Text("Hapus", style: TextStyle(color: Color(0xFF4D80DF)),),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _textField(String hintText, IconData icon, bool isPassword, bool isDigit, TextEditingController lController) {
    return TextFormField(
      controller: lController,
      keyboardType: isDigit? const TextInputType.numberWithOptions(decimal:true) : TextInputType.text,
      inputFormatters: isDigit ? [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*'))] : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hintText Harus Diisi';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.blueGrey),
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        filled: true,
        fillColor: Colors.white70,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.blueGrey),
    );
  }
  Future<dynamic> showAlertDialog(BuildContext context, String judul, String konten){
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Text(judul),
          content: Text(konten),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: const Text(
                'Batal',   
                style: TextStyle(color: Color(0xFF4D80DF),),             
              )
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).popUntil((route) => route.isFirst);
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              }, 
              child: const Text(
                'Ya',
                style: TextStyle(color: Colors.red),             
              )
            ),
          ],
        );
      }
    );
  }
}

class SelectableAvatar extends StatefulWidget {
  const SelectableAvatar({Key? key, this.url, this.index_avatar})
      : super(key: key);
  final String? url;
  final int? index_avatar;

  @override
  State<SelectableAvatar> createState() => _SelectableAvatarState();
}

class _SelectableAvatarState extends State<SelectableAvatar> {
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        child: Builder(
          builder: (context) {
            final FocusNode focusNode = Focus.of(context);
            final bool hasFocus = focusNode.hasFocus;
            return GestureDetector(
              onTap: () {
                focusNode.requestFocus();
                setState(() {
                  profile_index = int.parse(widget.index_avatar.toString());
                });
                print(profile_index);
              },
              child: _renderAvatar(hasFocus),
            );
          },
        ),
      ),
    );
  }

  Widget _renderAvatar(bool hasFocus) {
    final uri = widget.url != null ? Uri.tryParse(widget.url!) : null;
    final useDefault = uri == null;

    ImageProvider getProvider() {
      if (useDefault) {
        return const AssetImage('');
      }
      return AssetImage(widget.url!);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: hasFocus ? 120 : 100,
      height: hasFocus ? 120 : 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: hasFocus ? 3 : 2,
          color: hasFocus ? Color.fromRGBO(224, 46, 129, 1) : Colors.grey,
        ),
      ),
      child: CircleAvatar(
        foregroundColor: Colors.white,
        backgroundImage: getProvider(),
      ),
    );
  }
}