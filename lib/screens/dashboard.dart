import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/DatabaseManager/Database_manager.dart';
import 'package:flutter_app_with_firebase/screens/login_screen.dart';
import 'package:flutter_app_with_firebase/services/Authentication_service.dart';

class Dashboard extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Dashboard> {
  final AuthenticationServices auth = AuthenticationServices();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _scoreController = TextEditingController();

  List userProfileList = [];

  String userId = "";

  // Future getNameOfUser() async{
  //   DocumentSnapshot variable = await FirebaseFirestore.instance.collection('profileInfo').doc(userId).get();
  //   final currentName =  variable.data(DatabaseManager().itemList.add(name));
  // }
     



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDatabaseList();
    fetchUserInfo();
  }

  fetchUserInfo() async {
    User getUser = await FirebaseAuth.instance.currentUser;
    userId = getUser.uid;

  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfileList = resultant;
      });
    }
  }
   updateData(String name, String gender, int score, String userId) async{
    await DatabaseManager().updateUserList(name, gender, score, userId);
    fetchDatabaseList();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('',style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold ),),
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        actions: [
          RaisedButton(
            color: Colors.deepPurple,
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              openDialogBox(context);
            },
          ),
          RaisedButton(
            color: Colors.deepPurple,
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: userProfileList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(userProfileList[index]['name']),
                  subtitle: Text(userProfileList[index]['gender']),
                  leading: CircleAvatar(
                    child: Image(
                      image: AssetImage('assets/profile.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  trailing: Text('${userProfileList[index]['score']}'),
                ),
              );
            }),
      ),
    );
  }

  openDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Users Details'),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: 'Name'),
                  ),
                  TextField(
                    controller: _genderController,
                    decoration: InputDecoration(hintText: 'Gender'),
                  ),
                  TextField(
                    controller: _scoreController,
                    decoration: InputDecoration(hintText: 'Score'),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  submitActions(context);
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
              FlatButton(
                onPressed: () {

                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }

  submitActions(BuildContext context) {
    updateData(_nameController.text, _genderController.text, int.parse(_scoreController.text), userId );
    _nameController.clear();
    _genderController.clear();
    _scoreController.clear();
  }
}
