import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class alarm extends StatefulWidget {
  @override
  _alarmState createState() => _alarmState();
}

class _alarmState extends State<alarm> {
  bool alarmValue = false;
  var time = DateTime.parse("2020-08-19 08:56:00Z");
  int zoneDifference = 19682;
  String alarmTime = "04:00";
  int hour = 0;
  int min = 0;
  int result1 = 0;
  double result2 = 0;
  int result3 = 0;

  void alarmOn() {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: true, // Android only - API >= 28
      volume: 0.1, // Android only - API >= 28
      asAlarm: true, // Android only - all APIs
    );
  }

  int remainingTime = 0;
  void setAlarm() {
    setState(() {
      time = DateTime.parse(
          "${DateTime.now().toLocal().year.toString()}-${DateTime.now().toLocal().month.toString().padLeft(2, '0')}-${DateTime.now().toLocal().day.toString().padLeft(2, '0')} ${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}:00");
      remainingTime =
          (time.difference(DateTime.now().toLocal())).inSeconds.toInt();
      remainingTime < 0
          ? time = DateTime.parse(
              "${DateTime.now().toLocal().year.toString()}-${DateTime.now().toLocal().month.toString().padLeft(2, '0')}-${(DateTime.now().toLocal().day + 1).toString().padLeft(2, '0')} ${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}:00")
          : null;
      remainingTime =
          (time.difference(DateTime.now().toLocal())).inSeconds.toInt();
    });
  }

  void alarmOff() {
    setState(() {
      remainingTime = 0;
    });
  }

  Timer timer;
  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        setState(() {
          if (remainingTime > 0) {
            remainingTime--;
          }
        });
      });
    }
    if (remainingTime == 0 && alarmValue == true) {
      alarmOn();
    }
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FloatingActionButton(
                      backgroundColor: Colors.black,
                      heroTag: null,
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(7.0))),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.alarm_on,
                            color: Colors.white,
                          ),
                          Text(
                            'alarm',
                          )
                        ],
                      ))),
              Expanded(
                  child: FloatingActionButton(
                      backgroundColor: Color.fromRGBO(231, 240, 247, 1),
                      heroTag: null,
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(7.0))),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/first');
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.av_timer,
                            color: Colors.black,
                          ),
                          Text(
                            'timer',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ))),
              Expanded(
                  child: FloatingActionButton(
                backgroundColor: Color.fromRGBO(231, 240, 247, 1),
                heroTag: null,
                elevation: 8.0,
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(7.0))),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      color: Colors.black,
                    ),
                    Text(
                      'stopwatch',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              )),
            ],
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Text(
              "Alarm in ${(remainingTime / 3600).toInt()} hours \n                ${((remainingTime % 3600) / 60).toInt()}minutes",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ),
          FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
              backgroundColor: Color.fromRGBO(231, 240, 247, 1),
              heroTag: null,
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(7.0))),
              onPressed: () async {
                result2 = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => addAlarm(),
                    ));
                print(result2);
                result1 = result2.toInt();
                result3 = result1 < 2
                    ? ((result2 - result1) * 100).toInt()
                    : ((result2 - result1) * 100).toInt() + 1;
                print(result1);
                print(result3);
                setState(() {
                  hour = result1;
                  min = result3;
                });
                setAlarm();
                alarmValue = true;
              }),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Card(
                  elevation: 25.0,
                  color: Color.fromRGBO(231, 240, 247, 1),
                  child: Text(
                    hour.toString().padLeft(2, '0') +
                        ':' +
                        min.toString().padLeft(2, '0'),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                ),
                Card(
                    elevation: 25.0,
                    color: Color.fromRGBO(231, 240, 247, 1),
                    child: Switch(
                      value: alarmValue,
                      onChanged: (bool newValue) {
                        setState(() {
                          alarmValue = newValue;
                        });
                        alarmValue ? setAlarm() : alarmOff();
                      },
                    ))
              ],
            ),
          ),
          (remainingTime == 0)
              ? FloatingActionButton(
                  backgroundColor: Color.fromRGBO(231, 240, 247, 1),
                  heroTag: null,
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(7.0))),
                  child: Text('Stop', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    setState(() {
                      FlutterRingtonePlayer.stop();
                      alarmValue = false;
                      hour = 0;
                      min = 0;
                    });
                  })
              : SizedBox(),
        ],
      ),
    );
  }
}

class addAlarm extends StatefulWidget {
  @override
  _addAlarmState createState() => _addAlarmState();
}

class _addAlarmState extends State<addAlarm> {
  bool isChecked = false;
  int result1 = 0;
  int result2 = 0;
  bool sw = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(231, 240, 247, 1)),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(231, 240, 247, 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Card(
                          elevation: 25.0,
                          color: Color.fromRGBO(231, 240, 247, 1),
                          child: Text("Hour",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold)),
                        ),
                        NumberPicker.integer(
                          initialValue: result1,
                          maxValue: 23,
                          minValue: 0,
                          onChanged: (val) {
                            setState(() {
                              result1 = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Card(
                          elevation: 25.0,
                          color: Color.fromRGBO(231, 240, 247, 1),
                          child: Text("Minute",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold)),
                        ),
                        NumberPicker.integer(
                            initialValue: result2,
                            maxValue: 59,
                            minValue: 0,
                            onChanged: (val) {
                              setState(() {
                                result2 = val;
                              });
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.greenAccent,
              child: Card(
                child: Text(
                  "Ok",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                elevation: 25.0,
                color: Color.fromRGBO(231, 240, 247, 1),
              ),
              onPressed: () {
                Navigator.pop(context, (result1 + result2 / 100));
              },
            ),
          ],
        ),
      ),
    );
  }
}
