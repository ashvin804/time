import 'package:flutter/material.dart';
import 'timer.dart';
import 'inputpage.dart';
import 'alarm.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(time());

class time extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(231, 240, 247, 1),
        primaryColor: Color.fromRGBO(231, 240, 247, 1),
        primaryIconTheme: IconThemeData(color: Colors.black, size: 24.0),
        scaffoldBackgroundColor: Color.fromRGBO(231, 240, 247, 1),
        textTheme: TextTheme(
          headline1: GoogleFonts.dmSans(
            textStyle: TextStyle(
              fontSize: 43,
              fontWeight: FontWeight.w900,
              color: Color.fromRGBO(49, 68, 105, 1),
            ),
          ),
          headline4: GoogleFonts.dmSans(
            textStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(49, 68, 105, 1),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => InputPage(),
        '/first': (context) => settimer(),
        '/second': (context) => alarm()
      },
    );
  }
}
