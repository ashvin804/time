import 'dart:io';

import 'package:flutter/material.dart';

class Stopwatch {
  int miliseconds = 0;
  int sec = 0;
  int hours = 0;
  int min = 0;

  Stopwatch();
  String calc() {
    String milistr = miliseconds.toString();
    String secstr = sec.toString();
    String minstr = min.toString();
    while (miliseconds < 60) {
      Duration mili = Duration(milliseconds: 1);
      sleep(mili);
      miliseconds++;

      if (miliseconds == 60 && sec < 59) {
        sec++;
        if (sec < 10) {
          return '0' + secstr;
        } else if (sec >= 10 && sec < 60) {
          return secstr;
        } else {
          sec = 0;
          min++;
          if (min < 10) {
            return '0' + minstr;
          } else if (min >= 10 && min < 60) {
            return minstr;
          } else {
            min = 0;
            hours++;
            return minstr;
          }
        }
      }
      if (miliseconds < 10) {
        return '0' + milistr;
      } else if (miliseconds >= 10 && miliseconds < 60) {
        return milistr;
      } else {
        miliseconds = 0;
        return milistr;
      }
    }
  }
}
