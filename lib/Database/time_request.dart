import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/model/chat_reciver.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:flutter/material.dart';

class TimeRequestDatabase{
  Future negotiatetime(
  {
    required
  BuildContext ? context,
    required
    SchedulePickupTime ? pickuptime,
    required
  String ? chatid,
  required
  MyUser ? seller,
  required Product ? product

}
      )async{

    //
    SocialMediaDatabase _socila_database=SocialMediaDatabase();
    // await _socila_database.sendPushMessage(title: 'You have new message', body: "Request for Time Extend",
    //     token: '');


    await  _socila_database.addMessage(
        chatRoomId:chatid,
        chatMessageData: {
          'pickup_time': {
            'date':pickuptime!.date,
            'time':pickuptime.time,
            'comment':pickuptime.comment
          },
          'time':DateTime.now().millisecondsSinceEpoch,
          'expires_in':DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day+1
          ),
          'status':'in_progress',
          'SendBy':currentuser!.uid
        }).then((value) {
      Navigator.of(context!).pushNamed(
          Chat_Screen.routename,
          arguments:  ChatReciever(

              chatid: chatid,
              user:   seller,
              product:product
          )
      );
    });

  }
}
TimeRequestDatabase time_request_database=TimeRequestDatabase();