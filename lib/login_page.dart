import 'package:driver/gotoadmin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:driver/components/my_button.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';


class LoginPage extends StatefulWidget {
  @override
  _loginpagestate createState() => _loginpagestate();

}
// // sign user out method
// void signUserOut() {
//   FirebaseAuth.instance.signOut();
// }

class _loginpagestate extends State<LoginPage> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }
  // sign user in method
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
        wrongEmailMessage();
      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        // show error to user
        wrongPasswordMessage();
      }
    }
  }

  // wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Email',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                Padding(padding: const EdgeInsets.only(top: 5.0),
                  child: Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      child: Image.asset('images/Trackit.png'),
                    ),
                  ),
                ),

                // welcome back, you've been missed!
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 50),

              Form(
                  key: _formKey,
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [

                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_open)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),),

                // forgot password?
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
              ),
              onPressed: () {
                GoToAdmin();
              },
              child: Text('Forgot Password ?'),
            ),
                MyButton(
                  // onTap: signUserIn,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      signUserIn();
                      _listenLocation();

                    }
                  },
                ),

                // const SizedBox(height: 50),

              ],
            ),
          ),
        ),
      ),
    );
  }


  getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'name': 'bus'
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
    _listenLocation();
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection('location').doc('user1').set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': 'bus'
      }, SetOptions(merge: true));
    });
  }

  stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}

// getLocation() async {
//   try {
//     final loc.LocationData _locationResult = await location.getLocation();
//     await FirebaseFirestore.instance.collection('location').doc('user1').set({
//       'latitude': _locationResult.latitude,
//       'longitude': _locationResult.longitude,
//       'name': 'bus'
//     }, SetOptions(merge: true));
//     _listenLocation();
//   } catch (e) {
//     print(e);
//   }
// }
//
// Future<void> _listenLocation() async {
//   _locationSubscription = location.onLocationChanged.handleError((onError) {
//     print(onError);
//     _locationSubscription?.cancel();
//     setState(() {
//       _locationSubscription = null;
//     });
//   }).listen((loc.LocationData currentlocation) async {
//     await FirebaseFirestore.instance.collection('location').doc('user1').set({
//       'latitude': currentlocation.latitude,
//       'longitude': currentlocation.longitude,
//       'name': 'bus'
//     }, SetOptions(merge: true));
//   });
// }
//
// Future<void> stopListening() async{
//   _locationSubscription?.cancel();
//   setState(() {
//     _locationSubscription = null;
//   });
// }
//
// _requestPermission() async {
//   var status = await Permission.location.request();
//   if (status.isGranted) {
//     print('done');
//   } else if (status.isDenied) {
//     _requestPermission();
//   } else if (status.isPermanentlyDenied) {
//     openAppSettings();
//   }
// }
// }
//

