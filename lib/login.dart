import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'userInfo.dart' as userInfo;
import 'select.dart';

Color themecolor = Colors.redAccent;

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();

class LoginPage extends StatefulWidget {

  static final String route = "login-page";

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }

}

class LoginPageState extends State<LoginPage>{
  Future<FirebaseUser> _signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    userInfo.user = await auth.signInWithGoogle(
        idToken: gSA.idToken,
        accessToken: gSA.accessToken);

    print("user name: ${userInfo.user.displayName}");
    print("user email: ${userInfo.user.email}");
    print("user uid: ${userInfo.user.uid}");

    return userInfo.user;

  }



  Widget loginPage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        //color: themecolor,
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.3, 0.7, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            // Colors.yellow[100],
            Colors.red[200],
            Colors.red[300],
            Colors.red[500],
            Colors.red[600],
          ],
        ),
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: NetworkImage('https://images.pexels.com/photos/291732/pexels-photo-291732.jpeg?cs='
              'srgb&dl=adventure-cold-daylight-291732.jpg&fm=jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 250.0),
            child: Center(
              child: Icon(
                Icons.ac_unit,
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "HGUBnB",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  "App",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () {
                      _signIn().then((FirebaseUser user) {
                        Navigator
                            .of(context)
                            .push(MaterialPageRoute(
                            builder: (BuildContext context) => Select()

                        ))
                            .catchError((e) => print(e));
                      }
                      );
                    },
                    child: new Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Expanded(
                            child: Text(
                              "LOGIN WITH GOOGLE",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: themecolor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: PageView(
          physics: new AlwaysScrollableScrollPhysics(),
          children: <Widget>[loginPage()],
          scrollDirection: Axis.horizontal,
        ));
  }


}
