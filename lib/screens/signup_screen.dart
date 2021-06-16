import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/services/Authentication_service.dart';

import 'dashboard.dart';



class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _email;
  String _password;
  String _name;
 final AuthenticationServices auth = AuthenticationServices();



  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      color: Colors.deepPurpleAccent,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    this._name = value.trim();
                  });
                },
              ),
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

            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 20,),
                FlatButton(
                  onPressed: (){
                    createUser();

                  },

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 40,
                      width: 90,
                      color: Colors.white.withOpacity(0.9),
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: null,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 40,
                      width: 90,
                      color: Colors.white.withOpacity(0.9),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
              ],
            ),
          ],
        ),
      ),
    ),);
  }

  void createUser() async {
    dynamic result = await auth.createNewUser(_name, _email,_password);
    if(result==null){
      print('Email is not valid');
    } else{
      print(result.toString());
      Navigator.pop(context);
    }
  }
}
