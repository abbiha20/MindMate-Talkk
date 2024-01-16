import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ChatScreen.dart';
import 'Login.dart';

class Log extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the connection is still waiting, display a loading indicator or splash screen.
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          // If the user is logged in, navigate to ChatScreen.
          return ChatScreen();
        } else {
          // If the user is not logged in, show the login screen.
          return LoginPage();
        }
      },
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindMate Talk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Log(),
    );
  }
}
