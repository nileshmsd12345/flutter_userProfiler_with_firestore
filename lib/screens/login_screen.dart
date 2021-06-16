import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/screens/dashboard.dart';
import 'package:flutter_app_with_firebase/screens/signup_screen.dart';
import 'package:flutter_app_with_firebase/services/Authentication_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  AuthenticationServices auth = AuthenticationServices();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurpleAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      this._email = value.trim();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      this._password = value.trim();
                    });
                  },
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreen()));
                },
                child: Text(
                  'Not registered? Sign up',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 50),
              FlatButton(
                onPressed: (){
                  auth.signin(_email, _password);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Dashboard()));

                },

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 40,
                    width: 90,
                    color: Colors.white.withOpacity(0.9),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
