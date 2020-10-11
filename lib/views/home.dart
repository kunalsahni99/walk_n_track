import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: (){},
            child: Container(
              width: 80.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Coins'),
                  Icon(Icons.add_circle_outline_outlined)
                ],
              ),
            ),
          )
        ],
        title: Text('Walk n Track'),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 50.0),
          child: TabBar(
            labelPadding: EdgeInsets.only(bottom: 10.0),
            controller: tabController,
            tabs: [
              Text('Ongoing'),
              Text('My Challenges')
            ],
          ),
        ),
      ),
    );
  }
}
