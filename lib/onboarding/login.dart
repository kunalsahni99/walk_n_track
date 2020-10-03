import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/background.dart';
import '../views/mainpage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future gSignIn() async {
    GoogleSignInAccount gUser =
        await googleSignIn.signIn().catchError((onError) {
      print('1. ' + onError.toString());
    });

    if (gUser != null) {
      GoogleSignInAuthentication gSignInAuthentication =
          await gUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: gSignInAuthentication.idToken,
          accessToken: gSignInAuthentication.accessToken);
      final User user =
          (await auth.signInWithCredential(credential).catchError((onError) {
        print('2.' + onError.toString());
      }))
              .user;

      if (user != null) {
        //todo: use pushReplacement here
        Navigator.push(context, MaterialPageRoute(builder: (_) => MyApp()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) => ListView(
          padding: EdgeInsets.only(top: constraints.maxHeight >= 660.0 ? 100.0 : 60.0),
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: constraints.maxHeight >= 660.0 ? 150.0 : 120.0,
                    height: constraints.maxHeight >= 660.0 ? 150.0 : 120.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink[500],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 15.0,
                            spreadRadius: 0.5,
                            offset: Offset(10.0, 10.0),
                          )
                        ]),
                    child: Center(
                      child: Text(
                        'Welcome!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: constraints.maxHeight >= 660.0 ? 22.0 : 20.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 20.0,
                  left: 60.0,
                  child: Transform.rotate(
                    angle: 15 * (pi/180),
                    child: Icon(FontAwesomeIcons.walking, color: Colors.black87)
                  ),
                ),

                Positioned(
                  top: 85.0,
                  left: 100.0,
                  child: Transform(
                    transform: Matrix4.rotationY(pi),
                    child: Transform.rotate(
                      angle: 15 * (pi/180),
                      child: Icon(FontAwesomeIcons.running, color: Colors.black87)
                    ),
                  ),
                ),

                Positioned(
                  top: 10.0,
                  right: 60.0,
                  child: Transform.rotate(
                      angle: 15 * (pi/180),
                      child: Icon(FontAwesomeIcons.footballBall, color: Colors.black87)
                  ),
                ),

                Positioned(
                  top: 90.0,
                  right: 60.0,
                  child: Transform(
                    transform: Matrix4.rotationY(pi),
                    child: Transform.rotate(
                        angle: 15 * (pi/180),
                        child: Icon(FontAwesomeIcons.basketballBall, color: Colors.black87)
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: 50.0),

            Stack(
              alignment: Alignment.center,
              children: [
                Background(constraints: constraints),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: constraints.maxHeight >= 660.0 ? 30.0 : 20.0),
                  child: Column(
                    children: [
                      Text('It\'s easier to Sign in now',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                        ),
                      ),

                      SizedBox(height: 30.0),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Phone number',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ),

                      SizedBox(height: 10.0),

                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 6.0,
                                  offset: Offset(0, 2)
                              )
                            ]
                        ),
                        height: 60.0,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14.0),
                            prefixIcon: Icon(Icons.phone, color: Colors.white),
                            hintText: 'Phone no',
                            hintStyle: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5.0,
                          // TODO: Add phone authentication functionality
                          onPressed: (){
                            //TODO: Don't remove this line
                            Future.delayed(Duration(seconds: 1));
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                          color: Colors.white,
                          child: Text('Send OTP',
                            style: TextStyle(
                                color: Colors.pink,
                                letterSpacing: 1.5,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: constraints.maxHeight >= 660.0 ? 30.0 : 10.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('-  OR  -',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: constraints.maxHeight >= 660.0 ? 30.0 : 10.0),

                      Container(
                        padding: EdgeInsets.only(
                          left: 30.0,
                          right: 30.0,
                          //top: color == Colors.white ? (constraints.maxHeight >= 660.0 ? 15.0 : 10.0) : 0.0,
                          //bottom: color == Colors.white ? (constraints.maxHeight >= 660.0 ? 20.0 : 10.0) : 0.0
                        ),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: (){
                            Future.delayed(Duration(seconds: 1));
                            // if (color == Colors.white){
                            //   gSignIn();
                            // }
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          color: Colors.pink,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/google.png',
                                width: 30.0,
                                height: 30.0,
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text('Continue with Google',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}