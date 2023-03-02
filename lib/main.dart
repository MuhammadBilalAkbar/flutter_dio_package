import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Dio Package',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          textTheme: const TextTheme(
            labelLarge: TextStyle(fontSize: 30),
            titleMedium: TextStyle(fontSize: 30),
            bodySmall: TextStyle(fontSize: 30),
            bodyLarge: TextStyle(fontSize: 30),
            bodyMedium: TextStyle(fontSize: 25),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        home: const HomePage(),
      );
}
