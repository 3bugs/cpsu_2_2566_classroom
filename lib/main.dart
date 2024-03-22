import 'package:classroom/pages/home/home_page.dart';
import 'package:classroom/pages/login/login_page.dart';
import 'package:classroom/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CLASSROOM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          //brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      // home: const PinLoginPage(),
      home: FutureBuilder(
        future: AuthRepository().token,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
