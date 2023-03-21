import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),


    body: Center(
      child: Column(
        children: [
          Lottie.asset("images/green-tick.json"),
          Padding(padding: EdgeInsets. all(20),
          child: Text("Thank you for logging in. \n"
              "\nYour Attendance has been updated.",
        style: TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
          ),
    ),
        ],
      )
    // child: Padding(padding: EdgeInsets. all(50),
    // child: Text(
    //     "Thank you for logging in. \n"
    //     "\nYour Attendance has been updated",
    //
    //   style: TextStyle(
    //     color: Colors.blueGrey,
    //     fontWeight: FontWeight.bold,
    //     fontSize: 20,
    //   ),)
    ),);
  }
}