import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Background extends StatelessWidget {
  final BoxConstraints constraints;

  Background({this.constraints});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        child: WaveWidget(
          config: CustomConfig(
            colors: [
              Colors.pink[400],
              Colors.pink[300],
              Colors.pink[200],
              Colors.pink[100]
            ],
            durations: [18000, 8000, 5000, 12000],
            heightPercentages: constraints.maxHeight >= 660.0 ? [0.01, 0.02, 0.02, 0.03] : [0.01, 0.008, 0.008, 0.007],
          ),
          size: Size(double.infinity, double.infinity),
        ),
      ),
    );
  }
}