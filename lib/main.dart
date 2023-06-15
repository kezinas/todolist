import 'package:flutter/material.dart';
import 'package:todolist/first_screen.dart';
import 'package:todolist/second_screen.dart';
import 'themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeMode.system,
      routes: {
        '/main': (context) => FirstScreen(),
        '/editing': (context) => SecondScreen(),
      },
      home: FirstScreen(),
    );
  }
}
