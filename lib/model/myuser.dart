class MyUser {
  String ? uid;
  String ? email;
  String ? username;
  String ? location;
  String ? doc;
  String ? imageurl;
  final List<MyUser> ? request;
  final List<MyUser> ? friendlist;


  MyUser({this.uid,this.email,this.username,this.location,this.doc,this.imageurl,this.friendlist,this.request});

}
MyUser ? currentuser;
String user_id='';
String user_docid='';