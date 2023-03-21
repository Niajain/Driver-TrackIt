

import 'package:driver/auth_page.dart';
import 'package:driver/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:driver/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()


    );
  }
}
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//       body: StreamBuilder<User?>{
//       stream:FirebaseAuth.instance.authStateChanges(),
//       builder:(context,snapshot){
//       if(snapshot.hasData){
//       return HomePage();
//       }
//       else{
//       return LoginPage();
//       }
//       },
//       },