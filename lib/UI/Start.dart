import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:store_management/UI/HomePage.dart';
import 'LoginPage.dart';
import 'SignupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {


    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }

    return null;
  }


  navigateToLogin()async{

    Navigator.pushReplacementNamed(context, "Login");
  }

  navigateToRegister()async{

    Navigator.pushReplacementNamed(context, "SignUp");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Column(
          children: <Widget>[

            SizedBox(height: 35.0),

            Container(


              child: Image(image: AssetImage("assets/start.jpg"),
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height : 20),
            Padding(
              padding: EdgeInsets.only(left: 30,right: 30),
              child: RichText(

                  text: TextSpan(
                      text: 'Welcome to ', style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),

                      children: <TextSpan>[
                        TextSpan(
                            text: 'Store ', style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color:Colors.orange)
                        )
                      ]
                  )
              ),
            ),
            Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Text(
              "Management", style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color:Colors.orange),
            ),
            ),


            SizedBox(height: 10.0),

            Text('Manage Your Customers as you want to',style: TextStyle(color:Colors.black),),

            SizedBox(height: 30.0),


            Row( mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[

                RaisedButton(
                    padding: EdgeInsets.only(left:30,right:30),

                    onPressed: navigateToLogin,
                    child: Text('LOGIN',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.orange
                ),

                SizedBox(width:20.0),

                RaisedButton(
                    padding: EdgeInsets.only(left:30,right:30),

                    onPressed: navigateToRegister,
                    child: Text('REGISTER',style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.orange
                ),

              ],
            ),


            SizedBox(height : 20.0),

            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () {
                signInWithGoogle().then((result) {
                  if (result != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ),
                    );
                  }
                });
              },
            )
          ],
        ),
      ),

    );
  }
}