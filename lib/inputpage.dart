import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'timer.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class InputPage extends StatefulWidget {
  @override
  _inputState createState() => _inputState();
}

class _inputState extends State<InputPage> {
  int hours = 0;
  int min = 0;
  int sec = 0;
  int lapsec = 0;
  var button = true;
  Timer timer;
  var L = 0;
  var Lap = false;
  var str1 = 0;
  var str2 = 0;
  void laptone() {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass, // Android only - API >= 28
      volume: 0.1, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        setState(() {
          if (button == false) {
            lapsec++;
            sec++;
          }
          if (sec == 60) {
            sec = 0;
            min++;
          }
          if (min == 60) {
            min = 0;
            hours++;
          }
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FloatingActionButton(
                      backgroundColor: Color.fromRGBO(231, 240, 247, 1),
                      heroTag: null,
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(7.0))),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/second');
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.alarm_on,
                            color: Colors.black,
                          ),
                          Text(
                            'alarm',
                            style: TextStyle(color: Colors.black),
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
                backgroundColor: Colors.black,
                heroTag: null,
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(7.0))),
                child: Column(
                  children: <Widget>[
                    Icon(Icons.timer),
                    Text(
                      'stopwatch',
                    )
                  ],
                ),
              )),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 30.0,
                  shadowColor: Colors.white,
                  color: Color.fromRGBO(231, 240, 247, 1),
                  child: Column(
                    children: <Widget>[
                      Text(
                        hours.toString().padLeft(2, '0'),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 60.0),
                      ),
                      Text(
                        'hours',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
                Card(
                    elevation: 30.0,
                    shadowColor: Colors.white,
                    color: Color.fromRGBO(231, 240, 247, 1),
                    child: Column(
                      children: <Widget>[
                        Text(
                          min.toString().padLeft(2, '0'),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 60.0),
                        ),
                        Text(
                          'min',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    )),
                Card(
                  elevation: 30.0,
                  shadowColor: Colors.white,
                  color: Color.fromRGBO(231, 240, 247, 1),
                  child: Column(
                    children: <Widget>[
                      Text(
                        sec.toString().padLeft(2, '0'),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 60.0),
                      ),
                      Text(
                        'sec',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                        child: button
                            ? Text(
                                'start',
                                style: TextStyle(color: Colors.black),
                              )
                            : Text(
                                'stop',
                                style: TextStyle(color: Colors.black),
                              ),
                        elevation: 20.0,
                        backgroundColor: Color.fromRGBO(231, 240, 247, 1),
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0)),
                        heroTag: null,
                        onPressed: () {
                          setState(() {
                            button = !button;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                        backgroundColor: Color.fromRGBO(231, 240, 247, 1),
                        elevation: 20.0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0)),
                        heroTag: null,
                        child:
                            Text('Lap', style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          button
                              ? null
                              : setState(() {
                                  if (Lap == false) {
                                    str1 = lapsec;
                                  }
                                  if (Lap == true) {
                                    if (lapsec != 0) {
                                      L++;
                                    }
                                    str2 = lapsec;
                                    if (lapsec != 0) {
                                      laptone();
                                    }
                                  }
                                  Lap = !Lap;

                                  print(L);
                                });
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                        child: Text(
                          'Reset',
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Color.fromRGBO(231, 240, 247, 1),
                        elevation: 20.0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0)),
                        heroTag: null,
                        onPressed: () {
                          setState(() {
                            sec = 0;
                            min = 0;
                            hours = 0;
                            button = true;
                            L = 0;
                            Lap = false;
                            lapsec = 0;
                          });
                        }),
                  )
                ]),
            (Lap == false && L > 0)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Card(
                          elevation: 20.0,
                          color: Color.fromRGBO(231, 240, 247, 1),
                          child: Text(
                            'Lap_$L',
                            style: TextStyle(color: Colors.black),
                          )),
                      Card(
                          elevation: 20.0,
                          color: Color.fromRGBO(231, 240, 247, 1),
                          child: Text(
                            ((str2 - str1) ~/ 3600).toString().padLeft(2, '0') +
                                ':' +
                                (((str2 - str1) % 3600) ~/ 60)
                                    .toString()
                                    .padLeft(2, '0') +
                                ':' +
                                (((str2 - str1) % 3600) % 60)
                                    .toString()
                                    .padLeft(2, '0'),
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
