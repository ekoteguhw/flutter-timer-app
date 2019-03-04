import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(TimerApp());

class TimerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TimerAppState();
  }
}

class CustomTextContainer extends StatelessWidget{
  CustomTextContainer({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
            ),
          )
        ],
      ),
    );
  }
}

class TimerAppState extends State<TimerApp> {
  static const duration = const Duration(seconds: 1);

  int secondPassed = 0;
  bool isActive = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondPassed = secondPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null)
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    
    int seconds = secondPassed % 60;
    int minutes = secondPassed ~/ 60;
    int hours =secondPassed ~/ (60 * 60);

    return MaterialApp(
      title: 'Welcome to TimerApp!',
      home: Scaffold(
        appBar: AppBar(
          title: Text('TimerApp'),
          backgroundColor: Colors.blue,
          centerTitle: false,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextContainer(
                    label: 'HRS',
                    value: hours.toString().padLeft(2, '0'),
                  ),
                  CustomTextContainer(
                    label: 'MIN',
                    value: minutes.toString().padLeft(2, '0'),
                  ),
                  CustomTextContainer(
                    label: 'SEC',
                    value: seconds.toString().padLeft(2, '0'),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text(isActive ? 'STOP': 'START'),
                          color: Colors.green,
                          textColor: Colors.white70,
                          onPressed: () {
                            setState(() {
                              isActive = !isActive;
                            });
                          },
                        ),
                        RaisedButton(
                          child: Text('RESET'),
                          color: Colors.red,
                          textColor: Colors.white70,
                          onPressed: () {
                            setState(() {
                              isActive = false;
                              secondPassed = 0;
                            });
                          },
                        ),
                      ],
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}