import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dio_package/pages/create_user_page.dart';
import 'package:flutter_dio_package/pages/fetch_and_delete_user_page.dart';
import 'package:flutter_dio_package/pages/update_user_page.dart';

import 'json_models/UserModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          labelLarge: TextStyle(fontSize: 30),
          titleMedium: TextStyle(fontSize: 30),
          bodySmall: TextStyle(fontSize: 30),
          bodyLarge: TextStyle(fontSize: 30),
          bodyMedium: TextStyle(fontSize: 25),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio Basics'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const FetchAndDeleteUserPage()),
              ),
              child: const Text('Get/DeleteUserPage'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateUserPage()),
              ),
              child: const Text('CreateUserPage'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UpdateUserPage()),
              ),
              child: const Text('UpdateUserPage'),
            ),
          ],
        ),
      ),
    );
  }
}
