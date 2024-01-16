import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'FirebaseServices/auth_service.dart';
import 'logg.dart';
import 'SignUp.dart';
import 'google_signin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseServices _auth = FirebaseServices();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _showErrorSnackBar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 200),
                  child: Text(
                    "Welcome to MindMate Talk!",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      style: TextStyle(
                        color: Colors.pinkAccent,
                      ),
                      decoration: InputDecoration(
                        hintText: "Email",
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.pinkAccent,
                      ),
                      decoration: InputDecoration(
                        hintText: "Password",
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    try {
                      User? user = await _auth.signInMethod(email, password);
                      if (user != null) {
                        print("User is Signed In");
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Log()));
                      } else {
                        _showErrorSnackBar('Incorrect email or password. Please try again.');
                      }
                    } on FirebaseAuthException catch (e) {
                      // Handle login errors
                      print('Error: $e');
                      _showErrorSnackBar('Incorrect email or password. Please try again.');
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 100),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                    ),
                    child: Center(
                      child: Text("Login"),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    FirebaseService.signInwithGoogle();
                  },
                  child: Text("Log in with Google"),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'No account?',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
                        },
                        child: Text(
                          'Sign-Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
