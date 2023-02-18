import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../json_models/UserModel.dart';

class FetchAndDeleteUserPage extends StatefulWidget {
  const FetchAndDeleteUserPage({Key? key}) : super(key: key);

  @override
  State<FetchAndDeleteUserPage> createState() => _GetUserState();
}

class _GetUserState extends State<FetchAndDeleteUserPage> {
  final _dio = Dio();
  final _baseUrl = 'https://reqres.in/api';
  var _userInfo = '';
  final _idController = TextEditingController();
  bool _isFetching = false;
  bool _isDeleting = false;

  @override
  void dispose() {
    _idController;
    super.dispose();
  }

  Future<User?> getUser(String id) async {
    User? user;
    try {
      Response response = await _dio.get('$_baseUrl/users/$id');
      _userInfo = response.data.toString();
      if (kDebugMode) {
        print('User Info: $_userInfo');
      }
      user = User.fromJson(response.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (kDebugMode) {
          print('Dio error!');
          print('STATUS: ${e.response?.statusCode}');
          print('DATA: ${e.response?.data}');
          print('HEADERS: ${e.response?.headers}');
        }
      } else {
        // Error due to setting up or sending the request
        if (kDebugMode) {
          print('Error sending request!');
          print(e.message);
        }
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get/Fetch User'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _idController,
                decoration: const InputDecoration(hintText: 'Enter ID'),
              ),
              const SizedBox(height: 16.0),
              _isFetching
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isFetching = true;
                        });
                        await getUser(_idController.text);
                        setState(() {
                          _isFetching = false;
                          _userInfo;
                        });
                      },
                      child: const Text('Fetch/Get User'),
                    ),
              const SizedBox(height: 16.0),
              Text(_userInfo),
              const SizedBox(height: 16.0),
              _isDeleting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isDeleting = true;
                        });
                        try {
                          //This shows HTTP 204 No Content success status response code.
                          // It indicates that a request has succeeded, but that the
                          // client doesn't need to navigate away from its current page.
                          await _dio
                              .delete('$_baseUrl/users/${_idController.text}');
                          if (kDebugMode) {
                            print('User deleted! id: ${_idController.text}');
                          }
                        } catch (e) {
                          if (kDebugMode) {
                            print('Error deleting user: ${_idController.text}');
                          }
                        }
                        final snackBar = SnackBar(
                          content: Text(
                            'User at id ${_idController.text} is deleted successfully!',
                            style: const TextStyle(fontSize: 30),
                          ),
                        );
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                          _isDeleting = false;
                        });
                      },
                      child: const Text('Delete'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
