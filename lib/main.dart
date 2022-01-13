import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/sign_in_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAmIDyL46sbuS9zuajze4J953HRqHkd3z8",
      projectId: "fluttertest4-87e16",
      messagingSenderId: "715926525095",
      appId: "1:715926525095:web:1e3c9e2b7a55a7d39fb782",
      authDomain: "fluttertest4-87e16.firebaseapp.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '동계현장실습',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: const SignInScreen(),
    );
  }
}