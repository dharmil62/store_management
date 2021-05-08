import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_management/Menu/BalanceSheet.dart';
import 'package:store_management/Menu/Profile.dart';
import 'package:store_management/Menu/Settings.dart';
import 'package:store_management/Menu/Store.dart';
import 'package:store_management/UI/LoginPage.dart';


class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;



  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "Start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 0,
                    top: 20,
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white,),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: 34,
                    child: Text("xyz@gmail.com", style: TextStyle(fontFamily: 'jost', fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),),
                  ),
                  Positioned(
                    left: 10,
                    top: 90,
                    child: Text("xyz", style: TextStyle(fontFamily: 'jost', fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),),
                  ),
                  Positioned(
                    right: 5,
                    height: 80,
                    child: CircleAvatar(
                      radius: 70.0,
                      backgroundImage: AssetImage("assets/manage.png"),
                    ),
                  ),

                ],
              ),
            ),

            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 38, 1),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 1500,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Personal Profile'),
                      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()))},
                    ),
                    ListTile(
                      leading: Icon(Icons.store),
                      title: Text('Store/Shop Information'),
                      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => Store()))},
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Settings'),
                      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()))},
                    ),
                    ListTile(
                      leading: Icon(Icons.receipt),
                      title: Text('Balance Sheet'),
                      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => BalanceSheet()))},
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () => {

                      showDialog(
                      builder: (ctxt){
                      return AlertDialog(
                      title: Text("Logout",textAlign: TextAlign.center, style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15, fontFamily: 'jost', color: Colors.white,
                      ),),
                      content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Text("Do you Really want to logout?",textAlign: TextAlign.center, style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15, fontFamily: 'jost', color: Colors.black,
                      ),),
                      Padding(
                      padding: EdgeInsets.all(5),
                      ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      RaisedButton(
                      child: Text("Cancel"),
                      onPressed: () {
                      Navigator.pop(context);
                      },
                      ),
                      RaisedButton(
                      child: Text("Logout"),
                      onPressed: () {
                        signOut();
                      },
                      ),
                      ],
                      ),
                      ],
                      ),
                      );
                      },
                      context: context
                      ),
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
