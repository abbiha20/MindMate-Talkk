import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String apiKey = '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';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<String> messages = [];

  Future<void> sendMessage(String message) async {
    setState(() {
      messages.add("You: $message");
    });

    final Uri uri = Uri.parse('https://api.openai.com/v1/chat/completions');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final Map<String, dynamic> body = {
      'model': 'gpt-3.5-turbo-16k', // Updated model name
      'messages': [
        {'role': 'system', 'content': 'Hello! How are you doing?'},
        {'role': 'user', 'content': message}
      ],
    };

    try {
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        String reply = data['choices'][0]['message']['content'];
        setState(() {
          messages.add("ChatGPT: $reply");
        });
      } else {
        // Handle errors
        print("Error: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    } catch (error) {
      // Handle network errors
      print("Network Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: messages[index].startsWith("You")
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: messages[index].startsWith("You")
                              ? Colors.blueAccent
                              : Colors.greenAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          messages[index],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Check if user is logged in
                    FirebaseAuth.instance
                        .authStateChanges()
                        .first
                        .then((User? user) {
                      if (user != null) {
                        String message = _controller.text.trim();
                        if (message.isNotEmpty) {
                          sendMessage(message);
                          _controller.clear();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Log in first'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    });
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
