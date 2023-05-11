import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/Database/auth.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/finish.dart';
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

print("lala"+user_id.toString());
    return StreamBuilder(

        stream: authservice.user,

        builder: (_, AsyncSnapshot<MyUser?> snapshot) {

          final MyUser? user = snapshot.data;

          if(user!=null){

            user_id=user.uid!;

          }

          return user == null ?

          SignupWelcome() :

          HomeTesting();

        }

        );
  }
}