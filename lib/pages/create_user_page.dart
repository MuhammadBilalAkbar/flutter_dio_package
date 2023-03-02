import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final dio = Dio();
  final baseUrl = 'https://reqres.in/api';
  final nameController = TextEditingController();
  final jobController = TextEditingController();
  bool isCreating = false;
  String userInfo = '';

  @override
  void dispose() {
    nameController.dispose();
    jobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Create User'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Enter name'),
                ),
                TextField(
                  controller: jobController,
                  decoration: const InputDecoration(hintText: 'Enter job'),
                ),
                const SizedBox(height: 16.0),
                isCreating
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isCreating = true;
                          });
                          if (nameController.text != '' &&
                              jobController.text != '') {
                            final response = await dio.post(
                              '$baseUrl/users',
                              data: {
                                'name': nameController.text,
                                'job': jobController.text,
                              },
                              options: Options(
                                headers: {
                                  HttpHeaders.contentTypeHeader:
                                      'application/x-www-form-urlencoded',
                                },
                              ),
                            );
                            userInfo = response.data.toString();
                            debugPrint(response.statusCode.toString() +
                                response.data.toString());
                          }
                          setState(() {
                            isCreating = false;
                            userInfo;
                          });
                        },
                        child: const Text('Create User'),
                      ),
                const SizedBox(height: 16.0),
                Text(userInfo),
              ],
            ),
          ),
        ),
      );
}
