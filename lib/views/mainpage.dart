import 'dart:async';

import 'package:fit_kit/fit_kit.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final bool isCalled;
  final DateTime start, end;

  MyApp({this.isCalled = false, this.start, this.end});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result = '';
  Map<DataType, List<FitData>> results = Map();
  bool permissions, isLoading = false, firstTime = true;

  // DateTime get _dateFrom => _dates[_dateRange.start.round()];
  // DateTime get _dateTo => _dates[_dateRange.end.round()];
  DateTime startTime, endTime;

  @override
  void initState() {
    super.initState();
    if (widget.isCalled){
      startTime = widget.start;
      endTime = widget.end;
    }
    else{
      startTime = DateTime.now();
      endTime = DateTime.now().add(Duration(minutes: 10));
    }
    // _dates.add(null);
    // for (int i = 7; i >= 0; i--) {
    //   _dates.add(DateTime(
    //     now.year,
    //     now.month,
    //     now.day,
    //   ).subtract(Duration(days: i)));
    // }
    // _dates.add(null);

    hasPermissions();
    if (widget.isCalled){
      read();
    }
  }

  Future<void> read() async {
    results.clear();

    try {
      permissions = await FitKit.requestPermissions([DataType.STEP_COUNT, DataType.DISTANCE]);
      if (!permissions) {
        result = 'requestPermissions: failed';
      } else {
        for (DataType type in [DataType.STEP_COUNT, DataType.DISTANCE]) {
          try {
            results[type] = await FitKit.read(
              type,
              dateFrom: startTime,
              dateTo: endTime,
              limit: null,
            );
          } on UnsupportedException catch (e) {
            results[e.dataType] = [];
          }
        }

        result = 'readAll: success';
      }
    } catch (e) {
      result = 'readAll: $e';
    }

    setState(() {});
  }

  Future<void> revokePermissions() async {
    results.clear();

    try {
      await FitKit.revokePermissions();
      permissions = await FitKit.hasPermissions([DataType.STEP_COUNT]);
      result = 'revokePermissions: success';
    } catch (e) {
      result = 'revokePermissions: $e';
    }

    setState(() {});
  }

  Future<void> hasPermissions() async {
    try {
      permissions = await FitKit.hasPermissions([DataType.STEP_COUNT, DataType.DISTANCE]);
    } catch (e) {
      result = 'hasPermissions: $e';
    }

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final items = results.entries.expand((entry) => [entry.key, ...entry.value]).toList();

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('FitKit Example'),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                Text(
                    'Time Range: ${_dateToString(startTime)} - ${_dateToString(endTime)}'),
                Text('Permissions: $permissions'),
                Text('Result: $result'),
                _buildButtons(context),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      if (item is DataType) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            '$item - ${results[item].length}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        );
                      } else if (item is FitData) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          child: Text(
                            '$item',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        );
                      }

                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: Container(
            color: Colors.white..withOpacity(0.4),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        )
      ],
    );
  }

  String _dateToString(DateTime dateTime) {
    if (dateTime == null) {
      return 'null';
    }

    return '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
  }

  // Widget _buildDateSlider(BuildContext context) {
  //   return Row(
  //     children: [
  //       Text('Date Range'),
  //       Expanded(
  //         child: RangeSlider(
  //           values: _dateRange,
  //           min: 0,
  //           max: 9,
  //           divisions: 10,
  //           onChanged: (values) => setState(() => _dateRange = values),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget _buildLimitSlider(BuildContext context) {
  //   return Row(
  //     children: [
  //       Text('Limit'),
  //       Expanded(
  //         child: Slider(
  //           value: _limitRange,
  //           min: 0,
  //           max: 4,
  //           divisions: 4,
  //           onChanged: (newValue) => setState(() => _limitRange = newValue),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FlatButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () {
              if (!firstTime || widget.isCalled){
                setState(() => isLoading = true);
                Timer(
                  Duration(seconds: 2),
                  (){
                    setState(() => isLoading = false);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (_) => MyApp(isCalled: true, start: startTime, end: endTime)
                    ));
                  }
                );
              }
              else{
                read();
                setState(() => firstTime = false);
              }
            },
            child: Text('Read'),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
        Expanded(
          child: FlatButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () => revokePermissions(),
            child: Text('Revoke permissions'),
          ),
        ),
      ],
    );
  }
}