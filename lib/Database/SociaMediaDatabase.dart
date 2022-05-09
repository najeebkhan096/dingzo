import 'package:dingzo/Database/chatGroup.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SocialMediaDatabase{
  Future<void> addMessage(
      {String? chatRoomId, Map<String, dynamic>? chatMessageData}) async {
    FirebaseFirestore _intsance = FirebaseFirestore.instance;
    _intsance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData!)
        .catchError((e) {
      print(e.toString());
    });
  }


  Future<List<ChatGroup>> fetchGroup() async {
    List<ChatGroup> _post = [];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('groupChatRoom');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map fetcheddata = element.data() as Map<String, dynamic>;
        print("step5"+fetcheddata.toString());
        List<dynamic> data=fetcheddata['users'];
        List<MyUser> myusers=[];

        data.forEach((element) {

          myusers.add(MyUser(
              uid:
              element['userid'], email: element['email']
              ,username:  element['username'],imageurl:  element['image'],
             )
          );
        });

        if (fetcheddata['group'] == true) {

          _post.add(ChatGroup(
              docid: element.id,
              groupname: element.id,
              url: fetcheddata['groupdp'].toString(),
              members: myusers
          ));

        }


      });
    });

    print("khan baba" + _post[0].members.toString());
    return _post;
  }

  Future<void> addChatRoom(
      {Map<String, dynamic>? chatRoom, String? chatRoomId}) async {
    FirebaseFirestore _intsance = FirebaseFirestore.instance;
    _intsance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom!)
        .catchError((e) {
      print(e);
    });
  }
  Future<void> addGroupChatRoom(
      {
        List<MyUser> ? members, String? chatRoomId,String ?  dp}) async {
    FirebaseFirestore _intsance = FirebaseFirestore.instance;
    _intsance
        .collection("groupChatRoom")
        .doc(chatRoomId)
        .set({
      'group':true,
      'groupdp':dp,
      'users':members!.map((e) =>{
        'username': e.username,
        'email': e.email,
        'userid':e.uid,
        'image':e.imageurl,
        'admin':false,
      }).toList()
    })
        .catchError((e) {
      print(e);
    });
  }





  getChats(String chatRoomId) async {
    FirebaseFirestore _intsance = FirebaseFirestore.instance;
    return _intsance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }


  Future<void> addGroupMessage(
      {String? chatRoomId, Map<String, dynamic>? chatMessageData}) async {
    FirebaseFirestore _intsance = FirebaseFirestore.instance;
    _intsance
        .collection("groupChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData!)
        .catchError((e) {
      print(e.toString());
    });
  }



  Future<String> getUserChats(String user1,String user2) async {
    String chat_id ='';
    CollectionReference collection =
    FirebaseFirestore.instance.collection('chatRoom');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;
        List users = fetcheddata['users'];
        if (users.contains(user1) && users.contains(user2)) {
          addChatRoom(chatRoomId: element.id, chatRoom: {'users': users});
          chat_id=element.id;
        }
      });
    }).then((value) {

      if(chat_id.isEmpty){
        List users = [
          user1 ,
          user2
        ];

        chat_id = user1+
            "and" +
            user2;

        addChatRoom(chatRoomId: chat_id, chatRoom: {'users': users});

      }
    });

    return chat_id;
  }

  Future getUserInfogetChats(String user2) async {
    final result =await getUserChats(user_id,user2);
    return result;
  }


  Future AcceptRequest({
    List<MyUser> ? allfrdz,
    List<MyUser> ? allrequests,String ? senderID,String ? senderdocID}) async {

    print("before deletetion"+allrequests.toString());
    allrequests!.removeWhere((element) => element.uid==senderID);

    print("after deletetion"+allrequests.toString());


    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    collection.doc(senderdocID).set(
        {
          'request':    allrequests.map((e) => {
            'username':e.username,
            'userid':e.uid.toString(),
            'email':e.email.toString(),
            'imageurl':e.imageurl,
            'docid':e.doc
          }).toList()
        }

        , SetOptions(merge: true));

  }


  Future AddFriend_Sender({

    List<MyUser> ? allfrdz,
    MyUser ? newfriend,String ? docid}) async {
    FirebaseAuth _auth=FirebaseAuth.instance;
    final User? user = await _auth.currentUser;

    if(allfrdz!.any((element) => element.uid==newfriend!.uid))
    {

    }
    else{
      allfrdz.add(
          MyUser(
            doc: newfriend!.doc,
            imageurl: newfriend.imageurl,
            username: newfriend.username,
            email: newfriend.email,
            uid: newfriend.uid,
            request:newfriend.request ,
            friendlist: newfriend.friendlist,
          )
      );
    }

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    collection.doc(docid).set(
        {
          'friends':    allfrdz.map((e) => {
            'username':e.username,
            'userid':e.uid.toString(),
            'email':e.email.toString(),
            'imageurl':e.imageurl,
            'docid':e.doc
          }).toList()
        }

        , SetOptions(merge: true));

  }




  Future AddFriend_Reciever({
    MyUser ? reciverfrd,
    String ? recieverID,
    String ? senderDOCID,
  }) async {
    FirebaseAuth _auth=FirebaseAuth.instance;
    final User? user = await _auth.currentUser;


    List<MyUser> frdz=[];
    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {


        Map fetcheddata = element.data() as Map<String, dynamic>;

        if(fetcheddata['userid']==recieverID){


          List<dynamic> req=fetcheddata['friends'];

          req.forEach((element) {

            frdz.add(MyUser(
                doc: element['docid'],
                uid: element['id'].toString(),
                email: element['email'].toString(),
                username: element['username'].toString(),
                imageurl: element['imageurl'].toString(),
            ),
            );
          });
        }

      });
    });

//after getting all frds of sender
    MyUser ? newfriend;
    if(frdz.any((element) => element.uid==newfriend!.uid))
    {

    }
    else{
      newfriend=MyUser(
        doc: senderDOCID,
        email: user!.email,
        imageurl: user.photoURL,
        username: user.displayName,
        uid: user_id,
      );
      frdz.add(
          MyUser(
            doc: newfriend.doc,
            imageurl: newfriend.imageurl,
            username: newfriend.username,
            email: newfriend.email,
            uid: newfriend.uid,
          )
      );
    }

    collection =
        FirebaseFirestore.instance.collection('Users');
    collection.doc(reciverfrd!.doc).set(
        {
          'friends':    frdz.map((e) => {
            'username':e.username,
            'userid':e.uid.toString(),
            'email':e.email.toString(),
            'imageurl':e.imageurl,
            'docid':e.doc
          }).toList()
        }

        , SetOptions(merge: true));




  }



  Future SendRequest({MyUser ? reciever,String ? docid}) async {
    FirebaseAuth _auth=FirebaseAuth.instance;
    final User? user = await _auth.currentUser;

    List<MyUser>? requestlist=reciever!.request;
    if(requestlist!.any((element) => element.uid==element.uid))
    {

    }
    else{
      requestlist.add(
          MyUser(
            doc: docid,
            imageurl: user!.photoURL.toString(),
            username: user.displayName.toString(),
            email: user.email.toString(),
            uid: user_id.toString(),
            request: [],
            friendlist: [],
          )
      );
    }

    CollectionReference collection =
    FirebaseFirestore.instance.collection('Users');
    collection.doc(reciever.doc).set(
        {
          'request':    requestlist.map((e) => {
            'username':e.username,
            'userid':e.uid.toString(),
            'email':e.email.toString(),
            'imageurl':e.imageurl,
            'docid':docid
          }).toList()
        }

        , SetOptions(merge: true));

  }




}