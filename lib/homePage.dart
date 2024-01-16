import 'package:flutter/material.dart';
import 'Login.dart';
import 'ChatScreen.dart';
import 'WebTest.dart';
import 'Front.dart';
import 'SignUp.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    MyImageSlider(),
    ChatScreen(),
    WebViewScreen(),
    LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('MindMate Talk'),
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lightBlueAccent,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpPage()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            }
            );
          }
        },
        items: [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            backgroundColor: Colors.lightBlueAccent,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            backgroundColor: Colors.lightBlueAccent,
            label: 'Talk!',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            backgroundColor: Colors.lightBlueAccent,
            label: 'Test Yourself',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login_rounded),
            backgroundColor: Colors.lightBlueAccent,
            label: 'Login',
          ),
        ],
      ),
    );
  }
}

class TabScreen extends StatelessWidget {
  final String title;

  const TabScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

