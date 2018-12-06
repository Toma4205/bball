import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/ui/login_page.dart';
import 'package:the_gorgeous_login/ui/listview_player.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TheGorgeousLogin',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: _handleCurrentScreen(),
    );
  }

  Widget _handleCurrentScreen() {
    return new StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //return new SplashScreen();
            return new Container();
          } else {
            if (snapshot.hasData) {
              print("OK connect");
              print(snapshot.data.email);
              return new ListViewPlayer();
                // return new MainScreen(firestore: firestore,uuid: snapshot.data.uid);
            }
            return new LoginPage();
          }
        }
    );
  }
}

