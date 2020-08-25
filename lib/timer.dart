import 'dart:io';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class settimer extends StatefulWidget {
  @override
  _settimerState createState() => _settimerState();
}

class _settimerState extends State<settimer> {
  var l = [0, 0, 0, 0, 0, 0];

  var k = 0;
  var w = true;
  Timer timer;
  var c = 5;
  var intl;
  var totaltime = 1.0;
  var timeremain = 0.0;
  var buttoncilcked = 1;

  void _onKeyboardTap(String value) {
    if (k < 6) {
      setState(() {
        if (k == 2 && int.parse(value) >= 6) {
          l[k] = 5;
          l[k + 1] = 9;
          k = k + 2;
        } else if (k == 4 && int.parse(value) >= 6) {
          l[k] = 5;
          l[k + 1] = 9;
          k = k + 2;
        } else if (k == 5) {
          l[k] = int.parse(value);
          k++;
        } else {
          l[k] = int.parse(value);
          k++;
        }
      });
    } else {
      null;
    }
  }

  void playTone() {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: true,
      // Android only - API >= 28
      volume: 0.1,
      // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );
  }

  void C() {
    timeremain =
        ((l[0] * 10 + l[1]) * 3600 + (l[2] * 10 + l[3]) * 60 + l[4] * 10 + l[5])
            .toDouble();
    totaltime = timeremain;
  }

  @override
  Widget build(BuildContext context) {
    timeremain =
        ((l[0] * 10 + l[1]) * 3600 + (l[2] * 10 + l[3]) * 60 + l[4] * 10 + l[5])
            .toDouble();
    if (timer == null && w == false) {
      timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        setState(() {
          if (w == false) {
            if ((l[5] + l[4] * 10) != 0) {
              l[4] = ((l[5] + l[4] * 10) - 1) ~/ 10;
              l[5] = ((l[5] + l[4] * 10) - 1) % 10;
            } else if ((l[2] + l[3] * 10) != 0 && (l[5] + l[4] * 10) == 0) {
              l[2] = ((l[3] + l[2] * 10) - 1) ~/ 10;
              l[3] = ((l[3] + l[2] * 10) - 1) % 10;
              l[4] = 5;
              l[5] = 9;
            } else if ((l[0] + l[1] * 10) != 0 &&
                (l[5] + l[4] * 10) == 0 &&
                (l[2] + l[3] * 10) == 0) {
              l[0] = ((l[1] + l[0] * 10) - 1) ~/ 10;
              l[1] = ((l[1] + l[0] * 10) - 1) % 10;
              l[4] = 5;
              l[5] = 9;
              l[2] = 5;
              l[3] = 9;
            } else if (timeremain == 0) {
              playTone();
            }
          }
        });
      });
    }

    return Container(
      child: Scaffold(
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
                      Icon(Icons.alarm_on, color: Colors.black),
                      Text(
                        'alarm',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                )),
                Expanded(
                    child: FloatingActionButton(
                        backgroundColor: Colors.black,
                        heroTag: null,
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0))),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.av_timer),
                            Text('timer')
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
                    Navigator.of(context).pushNamed('/');
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.timer, color: Colors.black),
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
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                      elevation: 30.0,
                      shadowColor: Colors.white,
                      color: Color.fromRGBO(231, 240, 247, 1),
                      child: Column(
                        children: <Widget>[
                          Text(
                            l[0].toString() + l[1].toString(),
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
                      )),
                  Card(
                      elevation: 30.0,
                      shadowColor: Colors.white,
                      color: Color.fromRGBO(231, 240, 247, 1),
                      child: Column(
                        children: <Widget>[
                          Text(
                            l[2].toString() + l[3].toString(),
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
                            l[4].toString() + l[5].toString(),
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
                      )),
                ],
              ),
            ),
            w
                ? NumericKeyboard(
                    onKeyboardTap: _onKeyboardTap,
                    textColor: Colors.black,
                  )
                : SleekCircularSlider(
                    min: 0,
                    max: totaltime,
                    initialValue: timeremain,
                    appearance: CircularSliderAppearance(
                        counterClockwise: true,
                        startAngle: 90,
                        angleRange: 360,
                        size: 200.0,
                        customWidths: CustomSliderWidths(
                            trackWidth: 10.0,
                            progressBarWidth: 10.0,
                            handlerSize: 8.0),
                        customColors: CustomSliderColors(
                            trackColor: Colors.white,
                            progressBarColor: Colors.black,
                            dotColor: Colors.black)),
                  ),
            Expanded(
              child: Row(
                children: <Widget>[
                  FloatingActionButton(
                    child: w
                        ? Text(
                            'Start',
                            style: TextStyle(color: Colors.black),
                          )
                        : Text(
                            'Stop',
                            style: TextStyle(color: Colors.black),
                          ),
                    backgroundColor: Color.fromRGBO(231, 240, 247, 1),
                    heroTag: null,
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(7.0))),
                    onPressed: () {
                      if (k == 6 &&
                          (l[0] != 0 ||
                              l[1] != 0 ||
                              l[2] != 0 ||
                              l[3] != 0 ||
                              l[4] != 0 ||
                              l[5] != 0)) {
                        setState(() {
                          if (buttoncilcked == 1) {
                            C();
                          }
                          w = !w;
                          buttoncilcked++;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  FloatingActionButton(
                      backgroundColor: Color.fromRGBO(231, 240, 247, 1),
                      heroTag: null,
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(7.0))),
                      child: Text(
                        'Reset',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          l = [0, 0, 0, 0, 0, 0];
                          w = true;
                          k = 0;
                          FlutterRingtonePlayer.stop();
                        });
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
