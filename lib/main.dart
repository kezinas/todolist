import 'package:flutter/material.dart';
import 'package:todolist/first_screen.dart';
import 'package:todolist/second_screen.dart';
import 'themes.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      routes: {
        '/main': (context) => const FirstScreen(),
        '/editing': (context) => const SecondScreen(),
      },
      home: const FirstScreen(),
    );
  }
}
