import 'dart:convert';

import 'package:classroom/services/storage.dart';
import 'package:flutter/material.dart';

import '../../services/api_caller.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      checkToken().then((value) {
        if (value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        }
      });
    });
  }

  Future<bool> checkToken() async {
    var token = await Storage().read(Storage.keyToken);
    debugPrint('Token: $token');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 40.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.security, size: 80.0),
            Text('LOGIN', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 20.0),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Enter username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Enter password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _handleClickLogin,
              child: SizedBox(
                width: double.infinity,
                child: Text('Login', textAlign: TextAlign.center),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleClickLogin() async {
    print('Username: ${_usernameController.text}');
    print('Password: ${_passwordController.text}');

    var caller = ApiCaller();
    var data = await caller.post('login', params: {
      "username": _usernameController.text,
      "password": _passwordController.text
    });
    var json = jsonDecode(data);
    var token = json['token'];
    var fullName = json['user']['fullName'];
    debugPrint('Token: $token, Full Name: $fullName');

    var storage = Storage();
    storage.write(Storage.keyToken, token);
    storage.write(Storage.keyFullName, fullName);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }
}
