import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sipanda/auth/auth.dart';
import 'package:sipanda/pages/login.dart';

class RegisPage extends StatefulWidget {
  const RegisPage({Key? key}) : super(key: key);
  @override
  _RegisPageState createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  bool isPasswordVisible = false;
  bool _loading = false;
  String? _posyandu;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlName = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  final TextEditingController _ctrlConfirmPassword = TextEditingController();

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _ctrlEmail.text;
    final name = _ctrlName.text;
    final posyandu = _posyandu;
    const level = "Nonaktif";
    final password = _ctrlPassword.text;
    setState(() => _loading = true);
    if (password != _ctrlConfirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon periksa Kata Sandi'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => _loading = false);
      return;
    }
    try{
      await Auth().regis(email, password, name, posyandu.toString(), level.toString());
      FirebaseAuth.instance.signOut();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Akun Berhasil Didaftarkan'),
          backgroundColor:Color(0xFF4D80DF),
        ),
      );
    } catch (e) {
      showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text(
              'Terjadi Kesalahan'
            ),
            content: Text('$e'),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                child: const Text('Ok'))
            ],
          );
        });
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4D80DF), Color(0xFFA7E6FF)],
            begin: Alignment.center,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/logo.png',
                        height: 200,
                      ),
                      const Text(
                        'Daftar Akun Baru',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Silahkan Lengkapi Data',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _ctrlEmail,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Colors.blueGrey),
                          prefixIcon: const Icon(Icons.email, color: Colors.blueGrey),
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _ctrlName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Nama',
                          hintStyle: const TextStyle(color: Colors.blueGrey),
                          prefixIcon: const Icon(Icons.person, color: Colors.blueGrey),
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _posyandu,
                        items: const [
                          DropdownMenuItem<String>(
                            value: null,
                            child: Text(
                              'Pilih Posyandu',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Anggrek',
                            child: Text(
                              'Anggrek',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Cempaka',
                            child: Text(
                              'Cempaka',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                        ],
                        onChanged: (newValue) {
                          setState(() {
                            _posyandu = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Pilih Posyandu',
                          hintStyle: const TextStyle(color: Colors.blueGrey),
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Posyandu tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _ctrlPassword,
                        obscureText: !isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kata Sandi tidak boleh kosong';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Kata Sandi',
                          hintStyle: const TextStyle(color: Colors.blueGrey),
                          prefixIcon: const Icon(Icons.lock, color: Colors.blueGrey),
                          suffixIcon: GestureDetector(
                            onTap: togglePasswordVisibility,
                            child: Icon(
                              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _ctrlConfirmPassword,
                        obscureText: !isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Konfirmasi Kata Sandi tidak boleh kosong';
                          }
                          if (value != _ctrlPassword.text) {
                            return 'Mohon periksa Kata Sandi';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Konfirmasi Kata Sandi',
                          hintStyle: const TextStyle(color: Colors.blueGrey),
                          prefixIcon: const Icon(Icons.lock, color: Colors.blueGrey),
                          suffixIcon: GestureDetector(
                            onTap: togglePasswordVisibility,
                            child: Icon(
                              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white70,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: constraints.maxWidth,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () => handleSubmit(),
                          child: _loading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Daftar',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sudah Punya Akun? ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                            },
                            child: const Text(
                              'Masuk',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
