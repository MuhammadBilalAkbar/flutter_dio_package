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
  final _dio = Dio();
  final _baseUrl = 'https://reqres.in/api';
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  final _idController = TextEditingController();
  bool isCreating = false;
  var _userInfo = '';

  @override
  void dispose() {
    _nameController;
    _jobController;
    _idController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Update User')),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(hintText: 'Enter Id'),
                ),
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
                          if (_idController.text != '' &&
                              _nameController.text != '' &&
                              _jobController.text != '') {
                            var response = await _dio.put(
                              '$_baseUrl/users/$_idController',
                              data: {
                                'name': _nameController.text,
                                'job': _jobController.text,
                              },
                              options: Options(
                                headers: {
                                  HttpHeaders.contentTypeHeader:
                                      "application/x-www-form-urlencoded",
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
                        child: const Text('Update user'),
                      ),
                const SizedBox(height: 16.0),
                Text(_userInfo),
              ],
            ),
          ),
        ),
      );
}
