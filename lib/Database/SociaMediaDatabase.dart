import 'dart:convert';

import 'package:dingzo/Database/chatGroup.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
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

  Future<void> updateMessage(
      {String? chatRoomId, String ? status,
      String ? docid
      }) async {
    FirebaseFirestore _intsance = FirebaseFirestore.instance;
    _intsance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats").doc(docid).update({
      'status':status
    })
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



  Future<String> getUserChats({String ? user1,String ? user2,required String ?  productid}) async {
    String chat_id ='';
    CollectionReference collection =
    FirebaseFirestore.instance.collection('chatRoom');

    await collection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        Map<String, dynamic>? fetcheddata =
        element.data() as Map<String, dynamic>;
        List users = fetcheddata['users'];
        if (users.contains(user1) && users.contains(user2) && fetcheddata['product_id']==productid) {
          addChatRoom(chatRoomId: element.id, chatRoom: {
            'users': users,
          'product_id':productid
          });
          chat_id=element.id;
        }
      });
    }).then((value) {

      if(chat_id.isEmpty){
        List users = [
          user1 ,
          user2
        ];

        chat_id = user1!+
            "and" +
            user2!+"and"+productid!;

        addChatRoom(chatRoomId: chat_id, chatRoom: {'users': users,
          'product_id':productid
        });

      }
    });

    return chat_id;
  }

  Future getUserInfogetChats({String ? user2,required String ? product_id}) async {
    final result =await getUserChats(user1: user_id,user2: user2,productid:product_id );
    return result;
  }


  Future addfollowing({

    List<MyUser> ? allfrdz,
    MyUser ? newfriend,String ? docid}) async {
    FirebaseAuth _auth=FirebaseAuth.instance;


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
          'following':    allfrdz.map((e) => {
            'username':e.username,
            'userid':e.uid.toString(),
            'email':e.email.toString(),
            'imageurl':e.imageurl,
            'docid':e.doc
          }).toList()
        }

        , SetOptions(merge: true));

  }

  Future addfollower({

    List<MyUser> ? allfrdz,
    MyUser ? newfriend,String ? docid}) async {
    FirebaseAuth _auth=FirebaseAuth.instance;


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
          'followers':    allfrdz.map((e) => {
            'username':e.username,
            'userid':e.uid.toString(),
            'email':e.email.toString(),
            'imageurl':e.imageurl,
            'docid':e.doc
          }).toList()
        }
        , SetOptions(merge: true));
  }
  Future<void> sendPushMessage({required String ? title,required String ? body,required String ? token}) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAANsg9vGw:APA91bELSgg4VP-yqDIPdu0ZkFXWmM8gcouMTQn34XyBWdMxICRWz3gPFl-bJKL_V2cjcj9WbzgwoONfPB2aepNuMEyFl3JeHwdq44OBG4HD4CR7BMOFnwRpclh_eSqJRer-l3eWR0ii',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }


}
SocialMediaDatabase socialMediaDatabase=SocialMediaDatabase();