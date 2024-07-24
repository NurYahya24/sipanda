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
  String? _level;

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
    final level = _level;
    final password = _ctrlPassword.text;
    if (password != _ctrlConfirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() => _loading = false);
      return;
    }
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
                        'images/login.png',
                        height: 200,
                      ),
                      const Text(
                        'Create an Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Please fill in the details below',
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
                            return 'Email is still empty';
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
                            return 'Name is still empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Name',
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            const ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 16),
                              title: Text(
                                'Posyandu',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              leading: Icon(Icons.local_hospital, color: Colors.blueGrey),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text(
                                      'Anggrek',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    leading: Radio<String>(
                                      value: 'Anggrek',
                                      groupValue: _posyandu,
                                      onChanged: (value) {
                                        setState(() {
                                          _posyandu = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text(
                                      'Cempaka',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    leading: Radio<String>(
                                      value: 'Cempaka',
                                      groupValue: _posyandu,
                                      onChanged: (value) {
                                        setState(() {
                                          _posyandu = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _level,
                        items: const [
                          DropdownMenuItem<String>(
                            value: null,
                            child: Text(
                              'Select Level',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Super Admin',
                            child: Text(
                              'Super Admin',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Kader',
                            child: Text(
                              'Kader',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                        ],
                        onChanged: (newValue) {
                          setState(() {
                            _level = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Select Level',
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
                            return 'Level is still empty';
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
                            return 'Password is still empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
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
                            return 'Confirm Password is still empty';
                          }
                          if (value != _ctrlPassword.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
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
                                  'Register',
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
                            'Already have an account? ',
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
                              'Login',
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
