import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sipanda/auth/auth.dart';
import 'package:sipanda/pages/home.dart';
import 'package:sipanda/pages/regis.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();

  void togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  handleSubmit() async {
    if(!_formKey.currentState!.validate()) return;
    final email = _ctrlEmail.value.text;
    final password = _ctrlPassword.value.text;
    setState(() => _loading = true);
    try {
      await Auth().login(email, password);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil Masuk'),
          backgroundColor:Color(0xFF4D80DF),
        ),
      );
      setState(() => _loading = false);
    } catch (e) {
      print('Error saat login: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Terdapat Error',
            ),
            content: '$e' == '[firebase_auth/invalid-login-credentials] Error'
                ? const Text(
                    "Kata Sandi atau E-mail anda salah",
                  )
                : '$e' ==
                        '[firebase_auth/invalid-email] The email address is badly formatted.'
                    ? const Text(
                        "Silahkan Periksa Format E-mail Yang Anda Masukkan",
                      )
                    : Text(
                        "$e",
                      ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Anda berhasil login.'),
                      backgroundColor:Color(0xFF4D80DF),
                    ),
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                  setState(() => _loading = false);
                },
                child: const Text(
                  'OK',
                ),
              ),
            ],
          );
        },
      );
    }
    setState(() => _loading = false);
  }

  void _showDialogWithFields() {
    showDialog(
      context: context,
      builder: (_) {
        final _resetKey = GlobalKey<FormState>();
        var _ctrlEmailReset = TextEditingController();
        return AlertDialog(
          title: const Text('Form Reset Password', style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
          content: SingleChildScrollView(
            child: Form(
              key: _resetKey,
              child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customTextField('email', Icons.mail, false, _ctrlEmailReset)                   
                  ],
                ), 
              )
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color:Color(0xFF4D80DF))),
            ),
            TextButton(
              onPressed: () {
                if (_resetKey.currentState?.validate() ?? false){
                  Navigator.pop(context);
                  try{
                    FirebaseAuth.instance.sendPasswordResetEmail(email: _ctrlEmailReset.text);
                  }catch (e){
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Terjadi kesalahan'),
                          content: Text('$e'),
                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              }, 
                              child: const Text('Ok'))
                          ],
                        );
                      });
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Silahkan cek email anda'),
                      backgroundColor:Color(0xFF4D80DF),
                    ),
                  );
                }                
              },
              child: const Text('Kirim', style: TextStyle(color:Color(0xFF4D80DF))),
            ),
          ],
        );
      },
    );
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
                        'Selamat Datang!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Masuk Dengan Akun Anda',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 50),
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
                      const SizedBox(height: 30),
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
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              _showDialogWithFields();
                            },
                            child: const Text(
                              'Lupa Kata Sandi?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: constraints.maxWidth,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () => handleSubmit(),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child : _loading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Masuk',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Belum Punya Akun? ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RegisPage()),
                              );
                            },
                            child: const Text(
                              'Daftar',
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
  Widget customTextField(String hintText, IconData icon, bool isPassword, TextEditingController lController) {
    return TextFormField(
      controller: lController,
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
}
