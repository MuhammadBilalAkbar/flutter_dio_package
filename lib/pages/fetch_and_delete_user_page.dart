import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/UserModel.dart';

class FetchAndDeleteUserPage extends StatefulWidget {
  const FetchAndDeleteUserPage({Key? key}) : super(key: key);

  @override
  State<FetchAndDeleteUserPage> createState() => _GetUserState();
}

class _GetUserState extends State<FetchAndDeleteUserPage> {
  final dio = Dio();
  final baseUrl = 'https://reqres.in/api';
  var userInfo = '';
  final idController = TextEditingController();
  bool isFetching = false;
  bool isDeleting = false;

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  Future<User?> getUser(String id) async {
    User? user;
    try {
      final response = await dio.get('$baseUrl/users/$id');
      userInfo = response.data.toString();
      debugPrint('User Info: $userInfo');
      user = User.fromJson(response.data);
    } on DioError catch (error) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      debugPrint(error.message);
      if (error.response != null) {
        debugPrint(error.response!.statusCode.toString() +
            error.response!.data.toString() +
            error.response!.headers.toString());
      }
    }
    return user;
  }

  Future<void> deleteUser(String id) async {
    try {
      //This shows HTTP 204 No Content success status response code.
      // It indicates that a request has succeeded, but that the
      // client doesn't need to navigate away from its current page.
      await dio.delete('$baseUrl/users/${idController.text}');
      debugPrint('User deleted! id: ${idController.text}');
    } catch (e) {
      debugPrint('Error deleting user: ${idController.text}');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Get/Fetch User'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(hintText: 'Enter ID'),
                ),
                const SizedBox(height: 16.0),
                isFetching
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isFetching = true;
                          });
                          await getUser(idController.text);
                          setState(() {
                            isFetching = false;
                            userInfo;
                          });
                        },
                        child: const Text('Fetch/Get User'),
                      ),
                const SizedBox(height: 16.0),
                Text(userInfo),
                const SizedBox(height: 16.0),
                isDeleting
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isDeleting = true;
                          });
                          await deleteUser(idController.text);
                          final snackBar = SnackBar(
                            content: Text(
                              'User at id ${idController.text} is deleted successfully!',
                              style: const TextStyle(fontSize: 30),
                            ),
                          );
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {
                            isDeleting = false;
                          });
                        },
                        child: const Text('Delete User'),
                      ),
              ],
            ),
          ),
        ),
      );
}
