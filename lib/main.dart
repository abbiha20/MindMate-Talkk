import 'package:flutter/material.dart';
//import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'Welcomescreen.dart';
import 'homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized(); // initialize the instance
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await KommunicateFlutterPlugin.init('<APP_ID>');  //Defaultfirebase.current platform is used for initialization to your current
  //platform
  if(kIsWeb){ //this code is used when you have to initialize for web
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyDhZP62Y20JyN3JxF0G4FfRF0u6VpSzlY4',
          appId: '1:94766163166:web:d04e38e920657863d04e4f',
          messagingSenderId: '94766163166',
          projectId: 'mindmate-talk',
        )
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        MyHomePage.id: (context) => MyHomePage(),

      },
      home: WelcomeScreen(),
    );
  }
}