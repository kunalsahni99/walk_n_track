import 'package:flutter/material.dart';

import 'home.dart';
import 'profile.dart';
import 'widthdraw.dart';
import 'deposit.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currIndex = 0;
  List<Widget> pageList = [Home(), Profile(), Withdraw(), Deposit()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[currIndex],

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.blue,
          primaryColor: Colors.red
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Profile')),
            BottomNavigationBarItem(icon: Icon(Icons.money_sharp), title: Text('Deposit')),
            BottomNavigationBarItem(icon: Icon(Icons.attach_money), title: Text('Withdraw')),
          ],
          currentIndex: currIndex,
          onTap: (index) => setState(() => currIndex = index),
        ),
      ),
    );
  }

}
