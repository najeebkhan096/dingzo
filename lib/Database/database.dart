import 'dart:io';
import 'dart:typed_data';
import 'package:dingzo/Database/notification.dart';
import 'package:dingzo/Database/product_database.dart';
import 'package:dingzo/model/work_address.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/Database/payment.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/model/socialmedia.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

class Database{

  Future<List<String>> fetch_conversation_products() async {

    List<String> products=[];
List<String> querylist=[];
CollectionReference chatcollection =
FirebaseFirestore.instance.collection('chatRoom');

    await   chatcollection.get().then((QuerySnapshot snapshot) {

    snapshot.docs.forEach((element) {
      querylist.add(element.id);
      Map<String, dynamic>fetcheddata=element.data() as Map<String, dynamic>;
      print("jadu "+fetcheddata.toString());
      List<dynamic> conversation_users=fetcheddata['users'] as List<dynamic>;
        if(conversation_users.contains(currentuser!.uid)){
    products.add(fetcheddata['product_id']);
        }
    });

      });


    return products;
  }


  Future<String?> fetch_conversation_id_by_productid(String desired_product_id) async {
String ? chat_id='';

    CollectionReference chatcollection =
    FirebaseFirestore.instance.collection('chatRoom');

    await   chatcollection.get().then((QuerySnapshot snapshot) {
  snapshot.docs.forEach((element) {
    Map<String, dynamic>fetcheddata = element.data() as Map<String, dynamic>;

    if (fetcheddata['product_id'] == desired_product_id) {
      chat_id = element.id;
    }
  });
});
  return chat_id;

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
  Future<MyUser?> fetch_mini_user({String ? DesiredUserID}) async {



    MyUser ? desired_user=MyUser(
      vocation: false
    );
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) async {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;
        if(fetcheddata['userid']==DesiredUserID){

          Map<String,dynamic> address=fetcheddata['address'];

          bool vocation=fetcheddata['vocation'];


          List<Address> home_addresses=[];

          List<double> rating=[];


            desired_user.vocation=vocation;
            List<dynamic> home_add=fetcheddata['home_address'];
            if(home_add.length>0){
              home_add.forEach((address) {
                home_addresses.add(Address(
                    firstname: address['firstname'].toString(),
                    lastlast: address['lastname'].toString(),
                    address1: address['address1'].toString(),
                    address2: address['address2'].toString(),
                    city: address['city'].toString(),
                    state: address['state'].toString(),
                    zipcode:address['zipcode'].toString()
                ));
              });
              desired_user.home_address=home_addresses;

            }
            desired_user.location_details=WorkerAddress(
                address_txt: fetcheddata['location_details']['address_text'],
                latitude: fetcheddata['location_details']['latitude'],
                longitude: fetcheddata['location_details']['longitude']
            );
            desired_user.username=fetcheddata['username'];
            desired_user.imageurl=fetcheddata['imageurl'].toString();
            print("gashti "+ fetcheddata['location_details']['address_text']);
          }

            // useraddress=Address(
        //   vocation: vocation,
        //       firstname: address['firstname'].toString(),
        //       lastlast: address['lastname'].toString(),
        //       address1: address['address1'].toString(),
        //       address2: address['address2'].toString(),
        //       city: address['city'].toString(),
        //       state: address['state'].toString(),
        //       zipcode:address['zipcode'].toString()
        //   );








      });

    }).then((value) {});

    return desired_user;

  }

  Future<MyUser?> fetch_seller_mini_detail({String ? DesiredUserID}) async {



    MyUser ? seller_detail;
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) async {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;
        if(fetcheddata['userid']==DesiredUserID){

          seller_detail=MyUser(
            username: fetcheddata['username'],
            imageurl: fetcheddata['imageurl'],
            deviceid: fetcheddata['device_id'],
            doc: element.id
          );

        }



      });

    }).then((value) {});

    return seller_detail;

  }



  Future update_rating(String user_id, List<double> rates,BuildContext context) async {


    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    collection.doc(user_id).set(
        {
        'rating':rates
        }

        , SetOptions(merge: true));

  }

  Future update_saved_search_products_history(String user_id, List<String> history,BuildContext context) async {


    CollectionReference collection =
    FirebaseFirestore.instance.collection('Search Products History');
    await collection.doc(user_id).set(
        {
          'history':history,
        }

        , SetOptions(merge: true));

  }
  Future<List<String>> fetch_recent_saerch_history({String ? DesiredUserID}) async {

    List<String> history=[];

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Recent Search Products History');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) async {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;
        if(element.id==DesiredUserID){

          try{
            List<dynamic> search=fetcheddata['history'];
            if(search.length>0){
              search.forEach((element) {
                history.add(element);
              });
            }
          }catch(error){

          }
        }

      });

    }).then((value) {});

    return history;

  }
  Future update_recent_search_products_history(String user_id, List<String> history,BuildContext context) async {


    CollectionReference collection =
    FirebaseFirestore.instance.collection('Recent Search Products History');
    await collection.doc(user_id).set(
        {
          'history':history,
        }

        , SetOptions(merge: true));

  }


  Future update_filter_distance() async {


    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    await collection.doc(currentuser!.doc).update(
      {
        'filter_distance':currentuser!.filter_distance
      }
    );

  }



  Future<MyUser?> fetchprofiledata({String ? DesiredUserID}) async {
    ProductDatabase _prouctdatabase=ProductDatabase();

    List<Product> sold=await _prouctdatabase.fetch_sold_products_by_userid(desireduserid: DesiredUserID);
    List<Product> forSale=await _prouctdatabase.fetch_ForSale_products_by_userid(desireduserid: DesiredUserID);
    MyUser? user;
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
       snapshot.docs.forEach((element) async {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;
        if(fetcheddata['userid']==DesiredUserID){

          List<MyUser> followers=[];
          List<MyUser> following=[];
          List<Payment> userpayments=[];
          List<dynamic> followers_list=fetcheddata['followers'];
          List<dynamic> following_list=fetcheddata['following'];

          List<Address> home_addresses=[];

          List<double> rating=[];

          try{
            List<dynamic> home_add=fetcheddata['home_address'];
            if(home_add.length>0){
              home_add.forEach((address) {
                home_addresses.add(Address(
                    firstname: address['firstname'].toString(),
                    lastlast: address['lastname'].toString(),
                    address1: address['address1'].toString(),
                    address2: address['address2'].toString(),
                    city: address['city'].toString(),
                    state: address['state'].toString(),
                    zipcode:address['zipcode'].toString()
                ));
              });
            }
          }catch(error){

          }
          try{
            List<dynamic> ratinglist=fetcheddata['rating'];
            if(ratinglist.length>0){
              ratinglist.forEach((element) {
                rating.add(element);
              });
            }
          }catch(error){

          }






          Map<String,dynamic> address=fetcheddata['address'];
          List<dynamic> payment=fetcheddata['payment'];

   // Address userAddress=Address(
   //   firstname: address['firstname'].toString(),
   //   lastlast: address['lastname'].toString(),
   //   address1: address['address1'].toString(),
   //   address2: address['address2'].toString(),
   //   city: address['city'].toString(),
   //   state: address['state'].toString(),
   //   zipcode:address['zipcode'].toString()
   // );



          payment.forEach((element) {
            userpayments.add(Payment(
              city: element['city'].toString(),
              lastlast:  element['lastlast'].toString(),
              firstname:  element['firstname'].toString(),
              // address:  userAddress,
              cardnumber:  element['cardnumber'].toString(),

            ));
          });



          if(followers_list.length>0){
      followers_list.forEach((followersuser) {
      followers.add( MyUser(
      deviceid: fetcheddata['device_id'].toString(),
      email: followersuser['email'].toString(),
      username:  followersuser['username'].toString(),
      uid: followersuser[''],
      imageurl: followersuser['imageurl'].toString(),
      doc: followersuser['userid'],
      location: followersuser['location'].toString(),
    ));
  });

}
if(followers_list.length<0){

  following_list.forEach((followinguser) {

    following.add( MyUser(

      email: followinguser['email'].toString(),
      username:  followinguser['username'].toString(),
      uid: followinguser['userid'],
      imageurl: followinguser['imageurl'].toString(),
      doc: followinguser['docid'],
      location: followinguser['location'].toString(),
    ));
  });

}

          if (fetcheddata['userid'] == DesiredUserID) {

            user = MyUser(
              home_address: home_addresses,
              filter_distance: fetcheddata['filter_distance'],
                email: fetcheddata['email'].toString(),
                username:  fetcheddata['username'].toString(),
                uid: DesiredUserID,
                // address: userAddress,
                paymentmethod: userpayments,
                rating: rating,
                imageurl: fetcheddata['imageurl'].toString(),
                doc: element.id,
                stripe_account_id: fetcheddata['account_id'],
                location: fetcheddata['location'].toString(),
                vocation: fetcheddata['vocation'],
                accountcreated: fetcheddata['accountStatus'],
                suspend: fetcheddata['suspend'],
                location_details: WorkerAddress(
                  address_txt: fetcheddata['location_details']['address_text'],
                  latitude: fetcheddata['location_details']['latitude'],
                  longitude: fetcheddata['location_details']['longitude']
                ),
                socialMedia: SocialMedia(
                    follower: followers,
                    following: following,
                    followers: followers_list.length,
                    followings: following_list.length,
                    forSale: forSale,
                    item: 0,
                    rating: 0,
                    sold: sold
                ),
              deviceid: fetcheddata['device_id'],
              bio: fetcheddata['bio'].toString(),
            );
          }


        }



      });

    }).then((value) {});

    return user;

  }
  Future<String?> fetch_docid({String ? DesiredUserID}) async {
String ? docid;
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) async {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;
        if(fetcheddata['userid']==DesiredUserID){
          docid=element.id;
        }



      });

    }).then((value) {});

    return docid;

  }
  Future<List<double>> fetchrating({String ? DesiredUserID}) async {

    List<double> rating=[];

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) async {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;
        if(fetcheddata['userid']==DesiredUserID){

          try{
            List<dynamic> ratinglist=fetcheddata['rating'];
            if(ratinglist.length>0){
              ratinglist.forEach((element) {
                rating.add(element);
              });
            }
          }catch(error){

          }
        }

      });

    }).then((value) {});

    return rating;

  }
  Future<List<String>> fetch_saerch_history({String ? DesiredUserID}) async {

    List<String> history=[];

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Search Products History');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) async {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;
        if(element.id==DesiredUserID){

          try{
            List<dynamic> search=fetcheddata['history'];
            if(search.length>0){
              search.forEach((element) {
                history.add(element);
              });
            }
          }catch(error){

          }
        }

      });

    }).then((value) {});

    return history;

  }


  Future<String> adduser({String ? userid,String ? name,String ? email,String ? imageurl,String ? accountid,
  required WorkerAddress ? useraddress
  }) async {
    String ? docid='';

    Map<String, dynamic> data = {
      'username': name,
      'device_id':'',
      'online':true,
      'email': email,
      'suspend':false,
      'imageurl':imageurl,
      'location':'',
      'userid':userid,
      'admin':false,
     'followers':[],
      'accountStatus':false,
      'account_id':'',
      'following':[],
      'bio':'',
      'home_address':[],
      'address':{
        'firstname': '',
        'lastname': '',
        'address1': '',
        'address2': '',
        'city': '',
        'state': '',
        'zipcode':'',
        'account_id':false,
        'filter_distance':100
      },
      'filter_distance':100,
      'payment':[],
      'rating':[],
      'vocation':true,
      'location_details':{
        'address_text':useraddress!.address_txt,
        'latitude':useraddress.latitude,
        'longitude':useraddress.longitude
      },

    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result=await collection.add(data);
    docid=result.id;


    return docid;
  }
  Future<void> update_device_id({String ? deviceid}) async {


    Map<String, dynamic> data = {
      'device_id': deviceid,
    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result=await collection.doc(currentuser!.doc).update(data);

  }

  Future<void> update_online_status({required bool ? status}) async {


    Map<String, dynamic> data = {
      'online': status,
    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result=await collection.doc(currentuser!.doc).update(data);

  }

  Future<void> update_account_status({bool ? status}) async {
    String ? docid='';

    Map<String, dynamic> data = {
      'accountStatus': status,

    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result=await collection.doc(currentuser!.doc).update(data);

  }
  Future<void> update_account_id({String  ? id}) async {
    String ? docid='';

    Map<String, dynamic> data = {
      'account_id': id,
      'accountStatus':true,

    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result=await collection.doc(currentuser!.doc).update(data);

  }
  Future<void> update_drop_off_item_image({String ? orderid,String ? img}) async {


    Map<String, dynamic> data = {
      'drop_of_item_image': img,

    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');
    final result=await collection.doc(orderid).update(data);

  }
  Future<void> updateOrder({String ? orderid,String ?status,bool?  sellerrate,bool ? buyer_rate}) async {


    Map<String, dynamic> data = {
      'order_status': status,
      if(sellerrate!=null)
        'seller_rate':sellerrate,
      if(buyer_rate!=null)
        'buyer_rate':buyer_rate
    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');
    final result=await collection.doc(orderid).update(data);

  }

  Future<void> updateOrder_both_rating({String ? orderid,String ?status}) async {


    Map<String, dynamic> data = {
      'order_status': status,
'seller_rate':true,
        'buyer_rate':true
    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');
    final result=await collection.doc(orderid).update(data);

  }


  Future<void> updateOrder_rating_due_date({String ? orderid,bool?  sellerrate,bool ? buyer_rate}) async {


    Map<String, dynamic> data = {
      'rating_due_date': DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day+3,

      ),
    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Orders');
    final result=await collection.doc(orderid).update(data);

  }

  Future<void> updateProductStatus({String ? productid,String ?status,String ? orderid}) async {


    Map<String, dynamic> data = {
      'product_status': status,
      if(orderid!=null && orderid.isNotEmpty)
          'order_id':orderid
    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Products');
    final result=await collection.doc(productid).update(data);

  }
  Future<void> updatevocation({MyUser ? updateduser}) async {
    String ? docid='';

    Map<String, dynamic> data = {
      'vocation': updateduser!.vocation,

    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result=await collection.doc(currentuser!.doc).update(data);

  }
  Future<void> updateuser({MyUser ? updateduser}) async {
    String ? docid='';

    Map<String, dynamic> data = {
      'username': updateduser!.username,
      'imageurl':updateduser.imageurl,
      'bio':updateduser.bio

    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result=await collection.doc(currentuser!.doc).update(data);

  }

  // Future<void> updateUserAddress({MyUser ? updateduser}) async {
  //
  //   Map<String, dynamic> data = {
  //     'address':{
  //       'firstname': updateduser!.address!.firstname.toString(),
  //       'lastname': updateduser.address!.lastlast.toString(),
  //       'address1': updateduser.address!.address1.toString(),
  //       'address2': updateduser.address!.address2.toString(),
  //       'city': updateduser.address!.city.toString(),
  //       'state': updateduser.address!.state.toString(),
  //       'zipcode':updateduser.address!.zipcode.toString()
  //     },
  //   };
  //
  //
  //
  //   CollectionReference collection =
  //   FirebaseFirestore.instance.collection('Users');
  //   final result=await collection.doc(currentuser!.doc).update(data);
  //
  // }
  Future<void> updateUserHomeAddress({MyUser ? updateduser}) async {

    Map<String, dynamic> data = {
      'home_address':updateduser!.home_address!.map(
              (element) =>
      {
      'firstname': element.firstname,
      'lastname': element.lastlast.toString(),
      'address1': element.address1.toString(),
      'address2': element.address2.toString(),
      'city': element.city.toString(),
      'state': element.state.toString(),
      'zipcode':element.zipcode.toString(),
      'ExpirationDate':element.zipcode
      }
      ).toList(),
    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result=await collection.doc(currentuser!.doc).update(data);

  }
  Future<void> updateUserLocationDetails({WorkerAddress ? loc}) async {

    Map<String, dynamic> data = {
      'location_details':{
        'address_text':loc!.address_txt,
        'latitude':loc.latitude,
        'longitude':loc.longitude
      },
    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result=await collection.doc(currentuser!.doc).update(data);

  }

  Future<void> updateUserpayment({MyUser ? updateduser,int ?  index}) async {

    Map<String, dynamic> data = {
      'payemnt':{
        'firstname':updateduser!.paymentmethod![index!].firstname,
        'lastname':updateduser.paymentmethod![index].lastlast,
        'cardnumber':updateduser.paymentmethod![index].cardnumber,

        'ExpirationDate':'',
        'city':updateduser.paymentmethod![index].city,
      },
    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result=await collection.doc(currentuser!.doc).update(data);

  }
  Future<void> addUserpayment({MyUser ? updateduser}) async {

    Map<String, dynamic> data = {
      'payment':updateduser!.paymentmethod!.map(
              (e) => {
                'firstname':e.firstname.toString(),
                'lastname':e.lastlast.toString(),
                'cardnumber':e.cardnumber.toString(),
                'ExpirationDate':'',
                'city':e.city.toString(),

          }).toList(),
    };



    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    final result=await collection.doc(currentuser!.doc).update(data);

  }

  Future<void> googleSignIn({required BuildContext ? context,required WorkerAddress ? address}) async {

    final googleSignIn = GoogleSignIn();
    final signInAccount = await googleSignIn.signIn();

    final googleAccountAuthentication = await signInAccount!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAccountAuthentication.accessToken,
        idToken: googleAccountAuthentication.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    if (FirebaseAuth.instance.currentUser != null) {


      FirebaseAuth _auth=  FirebaseAuth.instance;
      User? newuser=_auth.currentUser;
      bool exist=await CheckUserExistance(newuser!.uid);
      if(exist){
        print("Already Created Account");
      }
      else{
        final result=await adduser(
        useraddress: address
        ,userid:newuser.uid ,name: newuser.displayName!,email: newuser.email,imageurl: newuser.photoURL.toString(),).then((value) async {
          user_docid=value.toString();
        });

      }


    } else {
      print('Unable to sign in');
    }
  }




  Future<List<SendNotification>> fetch_notification({String ? userid}) async {
    List<SendNotification> new_notification = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Notification');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;

        new_notification.add(SendNotification(
            title:
            fetcheddata['title'],
            description:
            fetcheddata['description'],
            image: fetcheddata['image_url'],
            item_name: fetcheddata['item_name'],
           date:
            fetcheddata['date']
        ));


      });
    }).then((value) {

    });

    return new_notification;
  }
  Future<bool> check_location_details({String ? DesiredUserID}) async {



  bool exist=false;
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) async {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;
        if(fetcheddata['userid']==currentuser!.uid){
          var data=fetcheddata['location_details'];
       if(data==null){
         exist=false;
       }
       else{
         exist=true;
       }

        }



      });

    }).then((value) {});

    return exist;

  }

}
Database database=Database();
List<Product> cartitems=[];