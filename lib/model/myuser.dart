import 'package:dingzo/model/socialmedia.dart';
import 'package:dingzo/model/work_address.dart';

class MyUser {
  String ? uid;
  String ? email;
  String ? username;
  String ? bio;
  String ? location;
  String ? doc;
  String ? imageurl;
  bool ? accountcreated=false;
  String ?  stripe_account_id;

  List<Address> ? home_address;
  List<Payment> ? paymentmethod;
  List<double> ? rating;
  final List<MyUser> ? request;
  final List<MyUser> ? friendlist;
  final SocialMedia ? socialMedia;
  bool ? vocation;
  final bool ? suspend;
   String ? deviceid;
   int ? filter_distance;
   WorkerAddress ? location_details;




  MyUser({this.deviceid,this.uid,this.email,this.username,this.location,this.doc,this.imageurl,this.friendlist,this.request,this.socialMedia,this.bio,this.paymentmethod,this.vocation,this.accountcreated,this.stripe_account_id,this.rating,this.suspend,this.filter_distance,
  this.location_details,
    this.home_address
  });

}

class Address{
  String ? firstname;
  String ? lastlast;
  String ? address1;
  String ? address2;
  String ? city;
  String ? state;
  String ? zipcode;
  bool ? vocation;
  String ? ExpiyDate;
  Address({this.firstname,this.lastlast,this.address1,this.address2,this.city,this.state,this.zipcode,this.vocation,this.ExpiyDate,});

}

class Payment{
  String ? firstname;
  String ? lastlast;
  String ? cardnumber;
  String ? cvv;
  DateTime ? ExpirationDate;
  String ? city;
  Address ? address;

  Payment({this.firstname,this.lastlast,this.cardnumber,this.ExpirationDate,this.city,this.address,this.cvv});

}

MyUser ? currentuser;
String user_id='';
String user_docid='';