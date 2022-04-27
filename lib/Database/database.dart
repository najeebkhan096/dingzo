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
      final result=await adduser(userid:newuser!.uid ,name: newuser.displayName!,email: newuser.email,imageurl: newuser.photoURL.toString()).then((value) async {
        user_docid=value.toString();
      });

    } else {
      print('Unable to sign in');
    }
  }


  CollectionReference ? imgRef;

  Future Add_Order(Order myorder) async {


    Map<String, dynamic> data = {
      'products': myorder.products!.map(
              (e) => {
            'title': e.title,
            'subtitle': e.description,
            'price': e.price,
            'total_price':e.total,
            'quantity':e.quantity,
            'prodoct_id':e.product_doc_id

          }).toList(),
      'notes': myorder.notes,
      'total_price': myorder.total_price,
      'date': myorder.date,
      'userid':user_id,
      'location':myorder.location,
      'customer_latitude':myorder.customer_latitude,
      'customer_longitude':myorder.customer_longitude,
      'customer_name':myorder.customer_name,
      'order_status':'ongoing',
      'restuarent_id':myorder.restuarent_id.toString()
    };
    print("ek baars");

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');
    collection.add(data);

  }

  Future uploadProduct({Product ? product})async{

    CollectionReference ? imgRef;
    Reference ? ref;

    imgRef = FirebaseFirestore.instance.collection('Products');
    imgRef.add({
      'title':product!.title,
      'description': product.description,
      'price':product.price,
      'photos': product.photos!.map(
    (e) => {
    'imageurl': e,
    }).toList(),
      'condition':product.condition,
      'category':product.category,
      'status':true,
      'seller_id':product.sellerid,
      'seller_name':product.sellername,
      'sales':product.sales,
      'brand':product.brand,
      'freeshipment':product.freeshipment,

    });
  }
  Future<List<Product>> fetch_products({String ? title}) async {

    List<Product> newCategories = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
        print("step1");
        List<dynamic> photos = fetcheddata['photos'];

        if (fetcheddata['category'] == title) {
          Product new_product = Product(
              title: fetcheddata['title'],
              price: fetcheddata['price'],
              quantity: 1,
              id: element.id,
              status: fetcheddata['status'],
              category: fetcheddata['category'],
              product_doc_id: element.id,
              description: fetcheddata['description'],
              total: 0,
              brand: fetcheddata['brand'],
              photos:photos
                  .map(
                    (e) => e['imageurl'].toString()
              )
                  .toList(),
              condition: fetcheddata['condition'],
              freeshipment: fetcheddata['freeshipment'],
              sellerid: fetcheddata['seller_id'],

              sales: fetcheddata['sales'],
              sellername: fetcheddata['seller_name'].toString()
          );
          newCategories.add(new_product);
        }

      });
    }).then((value) {
      newCategories.sort((a,b)=>a.sales!.toInt() .compareTo(b.sales!.toInt() ));
      newCategories=newCategories.reversed.toList();
    });

    return newCategories;
  }
}