import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/Database/auth.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/home.dart';
import 'package:dingzo/Authentication/login.dart';
import 'package:dingzo/Authentication/signup_welcome.dart';
import 'package:flutter/material.dart';



import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  static const routename = 'Wrapper';
  @override
  Widget build(BuildContext context) {


    final authservice = Provider.of<AuthService>(context);


    return StreamBuilder(
        stream: authservice.user,
        builder: (_, AsyncSnapshot<MyUser?> snapshot) {
          final MyUser? user = snapshot.data;
          if(user!=null){
            currentuser=MyUser(
                uid: user.uid,
                imageurl: user.imageurl,
                email: user.email,
                username: user.username,
                location: '',
                doc: user.doc
            );
            user_id=user.uid!;
            print("Current user id is "+user_id);
          }
          return user == null ? SignupWelcome() :HomeScreen();

        });
  }
}