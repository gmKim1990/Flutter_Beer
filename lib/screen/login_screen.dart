import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_beerrecord/main.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;

  _googleSignIn() async {
    final bool isSignedIn = await GoogleSignIn().isSignedIn();

    GoogleSignInAccount googleUser;

    if(isSignedIn) googleUser = await GoogleSignIn().signInSilently();
    else googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    final auth.User user = (await auth.FirebaseAuth.instance.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);

    FirebaseFirestore.instance.collection("users").doc(user.uid).get().then((value) async {
      if(value.data() == null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': user.email, 'create': DateTime.now()});
        print('Create data');
      }
    });
    return user;
  }

  @override
  Widget build(BuildContext context) {
    print('SignInPage');
    return Scaffold(
      appBar: AppBar(title: Text('Login Page'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _loading
              ? Text('Logging in')
              : Text('Click to Login'),
            _loading
              ? CircularProgressIndicator()
              : SignInButton(
                  Buttons.Google,
                  onPressed: () async {
                    try {
                      setState(() {
                        _loading = true;
                      });
                      await _googleSignIn();
                      auth.FirebaseAuth.instance.authStateChanges().listen((fu) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                      });
                      _loading = false;
                    } catch(e) {
                      print(e);
                    }
                  },
                )
          ],
        ),
      ),
    );
  }
}
