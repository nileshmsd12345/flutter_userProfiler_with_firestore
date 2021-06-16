import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_with_firebase/DatabaseManager/Database_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthenticationServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //Registration with email and password

  Future createNewUser(String name, String _email, String _password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      User user = result.user;
      await DatabaseManager().createUserData(name, 'Male', 100, user.uid);
      //success
      return user;
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.TOP);
    }
  }

  //Signin with email and password

  signin(String _email, String _password) async {
    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.TOP);
    }
  }

  //Signout

signOut()async{
  try {
    await auth.signOut();
  } on FirebaseAuthException catch (error) {
    Fluttertoast.showToast(msg: error.message, gravity: ToastGravity.TOP);
  }

}

}
