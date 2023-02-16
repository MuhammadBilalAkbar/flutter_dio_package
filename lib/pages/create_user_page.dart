// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
//
// class CreateUserPage extends StatefulWidget {
//   const CreateUserPage({Key? key}) : super(key: key);
//
//   @override
//   State<CreateUserPage> createState() => _CreateUserPageState();
// }
//
// class _CreateUserPageState extends State<CreateUserPage> {
//   final _dio = Dio();
//   final _baseUrl = 'https://reqres.in/api';
//   final _nameController = TextEditingController();
//   final _jobController = TextEditingController();
//   bool isCreating = false;
//
//   @override
//   void dispose() {
//     _nameController;
//     _jobController;
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Create User')),
//       body: Column(
//         children: [
//           TextField(
//             controller: _nameController,
//             decoration: const InputDecoration(hintText: 'Enter name'),
//           ),
//           TextField(
//             controller: _jobController,
//             decoration: const InputDecoration(hintText: 'Enter job'),
//           ),
//           const SizedBox(height: 16.0),
//           isCreating
//               ? const CircularProgressIndicator()
//               : ElevatedButton(
//                   onPressed: () async {
//                     setState(() {
//                       isCreating = true;
//                     });
//                     if (_nameController.text != '' &&
//                         _jobController.text != '') {
//                       await _dio.post('/test', data: {'id': 12, 'name': 'dio'});
//                       // UserInfo userInfo = UserInfo(
//                       //   name: _nameController.text,
//                       //   job: _jobController.text,
//                       // );
//                       //
//                       // UserInfo? retrievedUser =
//                       //     await _dioClient.createUser(userInfo: userInfo);
//
//                       if (retrievedUser != null) {
//                         showDialog(
//                           context: context,
//                           builder: (context) => Dialog(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text('ID: ${retrievedUser.id}'),
//                                     Text('Name: ${retrievedUser.name}'),
//                                     Text('Job: ${retrievedUser.job}'),
//                                     Text(
//                                       'Created at: ${retrievedUser.createdAt}',
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                     }
//
//                     setState(() {
//                       isCreating = false;
//                     });
//                   },
//                   child: const Text('Create user'),
//                 ),
//         ],
//       ),
//     );
//   }
// }
