import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../views/mainpage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future gSignIn() async {
    GoogleSignInAccount gUser = await googleSignIn.signIn()
        .catchError((onError) {
      print('1. ' + onError.toString());
    });

    if (gUser != null) {
      GoogleSignInAuthentication gSignInAuthentication = await gUser
          .authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: gSignInAuthentication.idToken,
          accessToken: gSignInAuthentication.accessToken);
      final User user = (await auth.signInWithCredential(credential)
          .catchError((onError) {
        print('2.' + onError.toString());
      })).user;

      if (user != null) {
        //todo: use pushReplacement here
        Navigator.push(context, MaterialPageRoute(
            builder: (_) => MyApp()
        ));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Login'),
          onPressed: () => gSignIn(),
        ),
      ),
    );
  }
}
