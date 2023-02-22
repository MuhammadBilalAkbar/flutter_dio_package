import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UpdateUserPage extends StatefulWidget {
  const UpdateUserPage({Key? key}) : super(key: key);

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final dio = Dio();
  final baseUrl = 'https://reqres.in/api';
  final nameController = TextEditingController();
  final jobController = TextEditingController();
  final idController = TextEditingController();
  bool isUpdating = false;
  var userInfo = '';

  @override
  void dispose() {
    nameController.dispose();
    jobController.dispose();
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Update User'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(hintText: 'Enter Id'),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Enter name'),
                ),
                TextField(
                  controller: jobController,
                  decoration: const InputDecoration(hintText: 'Enter job'),
                ),
                const SizedBox(height: 16.0),
                isUpdating
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isUpdating = true;
                          });
                          if (idController.text != '' &&
                              nameController.text != '' &&
                              jobController.text != '') {
                            var response = await dio.put(
                              '$baseUrl/users/$idController',
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
                            if (kDebugMode) {
                              print(response.statusCode);
                              print(response.data.toString());
                            }
                          }
                          setState(() {
                            isUpdating = false;
                            userInfo;
                          });
                        },
                        child: const Text('Update User'),
                      ),
                const SizedBox(height: 16.0),
                Text(userInfo),
              ],
            ),
          ),
        ),
      );
}
