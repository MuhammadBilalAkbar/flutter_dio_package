import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _dio = Dio();
  final _baseUrl = 'https://reqres.in/api';
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  bool isCreating = false;
  var _userInfo = '';

  @override
  void dispose() {
    _nameController;
    _jobController;
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
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: 'Enter name'),
                ),
                TextField(
                  controller: _jobController,
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
                          if (_nameController.text != '' &&
                              _jobController.text != '') {
                            var response = await _dio.post(
                              '$_baseUrl/users',
                              data: {
                                'name': _nameController.text,
                                'job': _jobController.text,
                              },
                              options: Options(
                                headers: {
                                  HttpHeaders.contentTypeHeader:
                                      'application/x-www-form-urlencoded',
                                },
                              ),
                            );
                            _userInfo = response.data.toString();
                            if (kDebugMode) {
                              print(response.statusCode);
                              print(response.data.toString());
                            }
                          }
                          setState(() {
                            isCreating = false;
                            _userInfo;
                          });
                        },
                        child: const Text('Create User'),
                      ),
                const SizedBox(height: 16.0),
                Text(_userInfo),
              ],
            ),
          ),
        ),
      );
}
