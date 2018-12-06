import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'userInfo.dart' as userInfo;
import 'select.dart';
import 'color.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();

class LoginPage extends StatefulWidget {
  static final String route = "login-page";

  @override
  State<StatefulWidget> createState() {
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

    return userInfo.user;
  }

  Widget loginPage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop),
          image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/airbnb-c9e3e.appspot.com/o/NINEJIP_PUR2.jpg?alt=media&token=dc89c51d-0180-4e85-8bf2-0753d48fca99'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height/1.4,),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white30.withOpacity(0.5),
                    onPressed: () {
                      _signIn().then((FirebaseUser user) {
                        Navigator
                            .of(context)
                            .push(MaterialPageRoute(
                            builder: (BuildContext context) => Select()

                        )).catchError((e) => print(e));
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
                            child: Text("LOGIN WITH GOOGLE", textAlign: TextAlign.center, style: TextStyle(color: deeppur, fontSize: 22, fontWeight: FontWeight.bold),
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