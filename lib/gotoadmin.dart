import 'package:flutter/material.dart';

class GoToAdmin extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("PLEASE CONTACT ADMIN",
          style: TextStyle(color: Colors.blueGrey[700], fontSize: 20,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),


    );
  }

}