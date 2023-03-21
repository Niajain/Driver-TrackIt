import 'package:driver/home_page.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
          height:60, //height of button
          width:300,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.blueGrey[800],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              "Sign In",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );

  }
}

//width of button
        // child: ElevatedButton(
        //   child: Text("Sign Up"),
        //   onPressed: () {
        //     HomePage();
        //     locationfetch();
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.blueGrey[800],
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10),
        //       side: BorderSide(
        //         color: Colors.teal,width: 2.0,),
        //     ),
        //
        //     padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        //     textStyle: TextStyle(
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold),
        //   ),
        // ),
