// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'home_page.dart';
//
// class HomePage extends StatelessWidget {
//   HomePage({super.key});
//
//   final user = FirebaseAuth.instance.currentUser!;
//
//   // sign user out method
//   void signUserOut() {
//     FirebaseAuth.instance.signOut();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         backgroundColor: Colors.grey[900],
//         actions: <Widget>[
//           IconButton(
//             icon: new Icon(Icons.logout_rounded),
//             onPressed: () {
//               signUserOut;
//               stopListening();
//             },
//
//           )
//         ],
//       ),);
//   }
//
//
//
// }
