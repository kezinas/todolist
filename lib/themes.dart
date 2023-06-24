import 'package:flutter/material.dart';

class Themes {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 247, 246, 242)),
      listTileTheme: const ListTileThemeData(tileColor: Colors.white),
      scaffoldBackgroundColor: const Color.fromARGB(255, 247, 246, 242),
      useMaterial3: true,
      textTheme: ThemeData.light().textTheme,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: const Color.fromARGB(255, 22, 22, 24),
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 22, 22, 24)),
      scaffoldBackgroundColor: const Color.fromARGB(255, 22, 22, 24),
      textTheme: ThemeData.dark().textTheme,
      listTileTheme:
          const ListTileThemeData(tileColor: Color.fromARGB(255, 60, 60, 63)),
      appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 22, 22, 24),
          titleTextStyle: TextStyle(color: Colors.white)),
      useMaterial3: true,
      hintColor: const Color.fromARGB(255, 142, 142, 147),
      iconTheme: const IconThemeData(color: Colors.white),
      canvasColor: const Color.fromARGB(255, 22, 22, 24),
      //dropdownMenuTheme: DropdownMenuThemeData(menuStyle: MenuStyle(backgroundColor: MaterialStateColor()))
    );
  }
}
