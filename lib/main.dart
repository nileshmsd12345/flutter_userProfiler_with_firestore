import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_with_firebase/screens/dashboard.dart';
import 'package:flutter_app_with_firebase/screens/login_screen.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();

runApp(MaterialApp(
debugShowCheckedModeBanner: false,
home: LoginScreen(),
       ));

}

