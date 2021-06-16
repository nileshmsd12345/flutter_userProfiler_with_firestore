import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('profileInfo');

//////create all the attributes of the user collection/////

  Future<void> createUserData(
      String name, String gender, int score, String uid) async {
    return await profileList.doc(uid).set({
      'name': name,
      'gender': gender,
      'score': score,
    });
  }



  ////update the data of current logged-in User/////

  Future updateUserList(String name, String gender, int score, String uid) async{
    return await profileList.doc(uid).update( {
      'name': name,
      'gender': gender,
      'score': score,
    });


  }
  List itemList = [];
/////fetch the data of the current logged in user////
  Future getUsersList() async {


    try {
      await profileList.get().then((querySnapShot) {
        querySnapShot.docs.forEach((element) {
          itemList.add(element.data());
        });
      });
      return itemList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  
}
