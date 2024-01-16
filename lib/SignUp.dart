import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'FirebaseServices/auth_service.dart';
import 'homePage.dart';
import 'Login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseServices _auth = FirebaseServices();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
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
                  padding: const EdgeInsets.only(left: 20, top: 200),
                  child: const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
                const Text(
                  "Join the Fam!",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.pinkAccent,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.pinkAccent,
                    ),
                    child: TextFormField(
                      controller: _usernameController,
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Username",
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.pinkAccent,
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Email",
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.pinkAccent,
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Password",
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 100),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.pinkAccent,
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        String name = _usernameController.text;
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        User? user = await _auth.signUpMethod(email, password);

                        if (user != null) {
                          print("User is successfully created");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MyHomePage()),
                          );
                        }
                      },
                      child: Text("Sign up"),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Text(
                        'Have an Account already?',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginPage()),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blue),
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
