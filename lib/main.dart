import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sipanda/firebase_options.dart';
import 'package:sipanda/pages/home.dart';
import 'package:sipanda/pages/login.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiPANDA',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.black,
          ),
          displaySmall: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.blueGrey
          ),
          labelLarge: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 13,
            color: Color.fromARGB(255, 255, 255, 255)
          )
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return const Home();
          }else{
            return const LoginPage();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}