import 'package:flutter/material.dart';
import 'package:flutter_dio_package/pages/create_user_page.dart';
import 'package:flutter_dio_package/pages/fetch_and_delete_user_page.dart';
import 'package:flutter_dio_package/pages/update_user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
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
                  MaterialPageRoute(
                      builder: (context) => const CreateUserPage()),
                ),
                child: const Text('CreateUserPage'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdateUserPage()),
                ),
                child: const Text('UpdateUserPage'),
              ),
            ],
          ),
        ),
      );
}
