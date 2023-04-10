import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  User? getCurrentUser() {
    // replace with your code to get the current user
  }

  Future<void> _addUser() async {
    final currentUser = getCurrentUser();

    if (currentUser?.role != 2) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must be an admin to access this page.')));
      return;
    }

    final newUser = {
      'name': nameController.text,
      'password': passwordController.text,
      'email': emailController.text,
    };

    final url = Uri.parse('http://127.0.0.1:8000/api/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${currentUser!.token}',
      },
      body: jsonEncode(newUser),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User added successfully')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error adding user')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add User"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _addUser,
                  child: const Text('Add User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class User {
  final String token;
  final int role;

  User({required this.token, required this.role});
}
