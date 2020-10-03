import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

import 'onboarding/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Root());
}

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Walk n Track',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.ubuntuTextTheme(
            Theme.of(context).textTheme
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Map<String, String> fitAvail;
  String url = 'https://play.google.com/store/apps/details?id=com.google.android.apps.fitness';

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () => getApps()
    );
  }

  Future<void> getApps() async{
    if (Platform.isAndroid){
      fitAvail = await AppAvailability.checkAvailability('com.google.android.apps.fitness');
      if (fitAvail.isNotEmpty){
        //todo: check if user is logged in or not; wrap this is another if statement
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (_) => Login()
        ));
      }
      else{
        if (await canLaunch(url)){
          await launch(url);
        }
      }
    }
    else if (Platform.isIOS){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Walk n Track',
          style: TextStyle(
            fontSize: 30.0
          ),
        ),
      ),
    );
  }
}