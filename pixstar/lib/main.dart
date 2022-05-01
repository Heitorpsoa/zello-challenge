import 'dart:ui';

import 'package:flutter/material.dart';
import './pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

const orange = Color.fromARGB(255, 255, 140, 50);
const lightGray = Color.fromARGB(255, 238, 238, 238);
const darkGray = Color.fromARGB(255, 133, 133, 133);
const blue = const Color.fromARGB(255, 6, 17, 60);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PixStar',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Roboto",
          primaryColor: orange,
          hintColor: darkGray,
          textTheme: const TextTheme(
            labelMedium: TextStyle(color: orange),
            headline2: TextStyle(color: orange, fontWeight: FontWeight.w700),
            headline6: TextStyle(
              color: lightGray,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(20)),
              backgroundColor: MaterialStateProperty.all<Color>(blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: orange),
                ),
              ),
            ),
          ),
          backgroundColor: blue,
          primaryColorDark: lightGray,
        ),
        home: const Scaffold(
          body: MainPage(),
        ));
  }
}
