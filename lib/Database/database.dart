import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

class Database{

  Future<List<MyUser>> fetchusers() async {
print("user func ");
    List<MyUser> request=[];
List<String> querylist=[];
CollectionReference chatcollection =
FirebaseFirestore.instance.collection('chatRoom');

    await   chatcollection.get().then((QuerySnapshot snapshot) {

    snapshot.docs.forEach((element) {
      querylist.add(element.id);
    });

      });

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {

        Map fetcheddata = element.data() as Map<String, dynamic>;

        String roomid=fetcheddata['userid']+"and"+user_id;
        String roomid2=user_id+"and"+fetcheddata['userid'];


        if(querylist.contains(roomid) ||querylist.contains(roomid2)  ) {
          request.add(MyUser(
            uid: fetcheddata['userid'].toString(),
            email: fetcheddata['email'].toString(),
            username: fetcheddata['username'].toString(),
            imageurl: fetcheddata['imageurl'].toString(),

          ),);
        }



      });
    });

print("final length is "+request.length.toString());
    return request;
  }

  Future<bool> CheckUserExistance (String loggeduserid) async {

    bool exist=false;

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {

        Map fetcheddata = element.data() as Map<String, dynamic>;

      if(fetcheddata['userid']==loggeduserid){
        exist=true;
      }
      });
    });


    return exist;
  }


  Future<MyUser?> fetchprofiledata({String ? DesiredUserID}) async {
    MyUser? user;
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;
        if (fetcheddata['userid'] == DesiredUserID) {
          print("found matched");
          user = MyUser(
              email: fetcheddata['email'].toString(),
              username:  fetcheddata['username'].toString(),
              uid: DesiredUserID,
              imageurl: fetcheddata['imageurl'].toString(),
              doc: element.id,
              location: fetcheddata['location'].toString(),
          );
        }
      });
    }).then((value) {});

    return user;

  }




  Future<String> adduser({String ? userid,String ? name,String ? email,String ? imageurl}) async {
    String ? docid='';

    Map<String, dynamic> data = {
      'username': name,
      'email': email,
      'imageurl':imageurl,
      'location':'',
      'userid':userid,
      'admin':false,
    };
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result=await collection.add(data);
    docid=result.id;
    print("so the result is "+result.id.toString());

    return docid;
  }



  Future<void> googleSignIn(BuildContext context) async {
    print("Google Sign function");
    final googleSignIn = GoogleSignIn();
    final signInAccount = await googleSignIn.signIn();

    final googleAccountAuthentication = await signInAccount!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAccountAuthentication.accessToken,
        idToken: googleAccountAuthentication.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    if (FirebaseAuth.instance.currentUser != null) {
      print('Google Authentication Successful');
      print('${FirebaseAuth.instance.currentUser!.displayName} signed in.');


      FirebaseAuth _auth=  FirebaseAuth.instance;
      User? newuser=_auth.currentUser;
      bool exist=await CheckUserExistance(newuser!.uid);
      if(exist){
        print("Already Created Account");
      }
      else{
        final result=await adduser(userid:newuser.uid ,name: newuser.displayName!,email: newuser.email,imageurl: newuser.photoURL.toString()).then((value) async {
          user_docid=value.toString();
        });
      }


    } else {
      print('Unable to sign in');
    }
  }






}

List<Product> cartitems=[];