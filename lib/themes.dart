import 'package:flutter/material.dart';

class Themes {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme:
          ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 247, 246, 242)),
      listTileTheme: ListTileThemeData(tileColor: Colors.white),
      scaffoldBackgroundColor: Color.fromARGB(255, 247, 246, 242),
      useMaterial3: true,
      textTheme: ThemeData.light().textTheme,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Color.fromARGB(255, 22, 22, 24),
      colorScheme:
          ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 22, 22, 24)),
      scaffoldBackgroundColor: Color.fromARGB(255, 22, 22, 24),
      textTheme: ThemeData.dark().textTheme,
      listTileTheme:
          ListTileThemeData(tileColor: Color.fromARGB(255, 60, 60, 63)),
      appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 22, 22, 24),
          titleTextStyle: TextStyle(color: Colors.white)),
      useMaterial3: true,
      hintColor: Color.fromARGB(255, 142, 142, 147),
      iconTheme: IconThemeData(color: Colors.white),
      canvasColor: Color.fromARGB(255, 22, 22, 24),
      //dropdownMenuTheme: DropdownMenuThemeData(menuStyle: MenuStyle(backgroundColor: MaterialStateColor()))
    );
  }
}
