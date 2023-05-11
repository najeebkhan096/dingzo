import 'dart:async';

import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:intl/intl.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/screens/chat/chat_bubble.dart';
import 'package:flutter/material.dart';
class TimeRequestChatBubble extends StatefulWidget{
  TimeRequestChatMessage chatMessage;
  final String ? chatid;
  final String ? docid;
  final String ? order_id;
  TimeRequestChatBubble({required this.chatMessage,this.docid,this.chatid,this.order_id});
  @override
  _TimeRequestChatBubbleState createState() => _TimeRequestChatBubbleState();
}

class _TimeRequestChatBubbleState extends State<TimeRequestChatBubble> {
  Constants _const=Constants();
  Timer ? _timer;
  @override
  void initState() {
    // TODO: implement initState
if(widget.chatMessage.status=='in_progress'){
  _timer=Timer.periodic(const Duration(seconds: 1), (Timer t) {

    bool expred=widget.chatMessage.expires_in!.isAfter(DateTime.now());

    SocialMediaDatabase _socila_database=SocialMediaDatabase();
    if(expred==false){
      _socila_database.updateMessage(
          chatRoomId: widget.chatid,
          docid: widget.docid,
          status: 'expired'
      );

    }
    else{
      setState(() {

      });
    }

  });
}
else{
  if(_timer!=null){
    _timer!.cancel();
  }

}

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
      if(_timer!=null){
        _timer!.cancel();
      }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
print("current time is "+DateTime.now().minute.toString());
    return Container(

      padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
      child: Align(
          alignment: (widget.chatMessage.type == MessageType.Receiver?Alignment.topLeft:Alignment.topRight),
          child: widget.chatMessage.type == MessageType.Receiver?



          Container(
            width: width*0.6,

            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: mycolor,

            ),
            child: Column(
              children: [
                Container(
                  width: width*0.6,
                  margin: EdgeInsets.only(right: width*0.025),

                  padding: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.025,top: height*0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.chatMessage.message.toString(),style: _const.manrope_regularwhite(13, FontWeight.w500)),
                      SizedBox(height: height*0.01,),
                      Text("Pickup Date:",style: _const.manrope_regularwhite(15, FontWeight.w800)),

                      Text("${DateFormat('yMMMMEEEEd').format(widget.chatMessage.picuptime!.date!)} at ${widget.chatMessage.picuptime!.time} ",style: _const.manrope_regularwhite(14 , FontWeight.w800),)
                      ,
                      SizedBox(height: height*0.0125,),
                      if(widget.chatMessage.status=="in_progress")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(

                             onTap: ()async{
if(widget.order_id!=null){
  if(widget.order_id!.isNotEmpty){
    SocialMediaDatabase _socila_database=SocialMediaDatabase();
    await  orderdatabase.update_pickup_time(
        orderdocid: widget.order_id,
        pickuptime: widget.chatMessage.picuptime
    );

    await  _socila_database.updateMessage(
        chatRoomId: widget.chatid,
        docid: widget.docid,
        status: 'accepted'
    );
  }
}

                             },
                              child: Container(
                                height: height*0.04,
                                margin: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                decoration: BoxDecoration(
                                    color: Color(0xffBCEFE0),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(child: Text("Accept",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                              ),
                            ),
                          ),

                          Expanded(
                            child: InkWell(
                              onTap: ()async{
                                SocialMediaDatabase _socila_database=SocialMediaDatabase();
                                await  _socila_database.updateMessage(
                                    chatRoomId: widget.chatid,
                                    docid: widget.docid,
                                    status: 'cancelled'
                                );
                              },
                              child: Container(
                                height: height*0.04,
                                margin: EdgeInsets.only(left: width*0.02,right: width*0.02),
                                decoration: BoxDecoration(
                                    color: Color(0xffF5CCCC),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(child: Text("Cancel",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if(widget.chatMessage.status=="in_progress")
                      SizedBox(height: height*0.0125,),

                      Container(
                          alignment: Alignment.centerRight,
                          child: Text(widget.chatMessage.picuptime!.time.toString(),style: _const.manrope_regular_087F5B(11 , FontWeight.w800),))
                      ,



                    ],
                  ),

                ),
                Container(
                  height: height*0.05,
                  width: width*1,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(26, 90, 71, 0.9),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/expire.png",height: height*0.025,),
                      SizedBox(width: width*0.025,),
                      widget.chatMessage.status=="expired"?
                      Text("Expired"
                        ,style: _const.manrope_regularwhite (13 , FontWeight.w800),)
                          :

                      widget.chatMessage.status=="cancelled"?
                      Text("Cancelled"
                        ,style: _const.manrope_regularwhite (13 , FontWeight.w800),):
                      widget.chatMessage.status=="accepted"?
                      Text("Accpeted"
                        ,style: _const.manrope_regularwhite (13 , FontWeight.w800),)
                          :

                      widget.chatMessage.expires_in!.difference(
                          DateTime.now()
                      ).inHours>0?
                      Text("Expires in "
                          "${widget.chatMessage.expires_in!.difference(
                          DateTime.now()
                      ).inHours
                      }"
                          +
                          " hours"
                        ,style: _const.manrope_regularwhite (13 , FontWeight.w800),):

                      widget.chatMessage.expires_in!.difference(
                          DateTime.now()
                      ).inMinutes>0?

                      Text("Expires in "
                          "${widget.chatMessage.expires_in!.difference(
                          DateTime.now()
                      ).inMinutes
                      }"
                          +
                          " minutes"
                        ,style: _const.manrope_regularwhite (13 , FontWeight.w800),):
                      Text("Expires in "
                          "${widget.chatMessage.expires_in!.difference(
                          DateTime.now()
                      ).inSeconds
                      }"
                          +
                          " seconds"
                        ,style: _const.manrope_regularwhite (13 , FontWeight.w800),)
                      ,
                    ],
                  ),
                ),
              ],
            ),
          )
              :

          Container(
            width: width*0.6,

            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: mycolor,

            ),
            child: Column(
              children: [
                Container(
                  width: width*0.6,
                  margin: EdgeInsets.only(right: width*0.025),

                  padding: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.025,top: height*0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.chatMessage.message.toString(),style: _const.manrope_regularwhite(13, FontWeight.w500)),
                      SizedBox(height: height*0.01,),
                      Text("Pickup Date:",style: _const.manrope_regularwhite(15, FontWeight.w800)),

        Text("${DateFormat('yMMMMEEEEd').format(widget.chatMessage.picuptime!.date!)} at ${widget.chatMessage.picuptime!.time} ",style: _const.manrope_regularwhite(14 , FontWeight.w800),)
,

                      SizedBox(height: height*0.0125,),

                      Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            DateFormat.jm().format(widget.chatMessage.time!)
                            ,style: _const.manrope_regular_087F5B(11 , FontWeight.w800),))
                      ,



                    ],
                  ),

                ),
                Container(
                  height: height*0.05,
                  width: width*1,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(26, 90, 71, 0.9),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10)
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/expire.png",height: height*0.025,),
                      SizedBox(width: width*0.025,),
                      widget.chatMessage.status=="expired"?
                      Text("Expired"
                        ,style: _const.manrope_regularwhite (13 , FontWeight.w800),)
                          :

                      widget.chatMessage.status=="cancelled"?
                      Text("Cancelled"
                        ,style: _const.manrope_regularwhite (13 , FontWeight.w800),):
                      widget.chatMessage.status=="accepted"?
                      Text("Accpeted"
                        ,style: _const.manrope_regularwhite (13 , FontWeight.w800),)
                          :

                      widget.chatMessage.expires_in!.difference(
                          DateTime.now()
                      ).inHours>0?
                      Text("Expires in "
                          "${widget.chatMessage.expires_in!.difference(
                          DateTime.now()
                      ).inHours
                      }"
                          +
                          " hours"
                        ,style: _const.manrope_regularwhite (13 , FontWeight.w800),):

                      widget.chatMessage.expires_in!.difference(
                          DateTime.now()
                      ).inMinutes>0?

                      Text("Expires in "
                          "${widget.chatMessage.expires_in!.difference(
                          DateTime.now()
                      ).inMinutes
                      }"
                          +
                          " minutes"
                        ,style: _const.manrope_regularwhite (13 , FontWeight.w800),):
                      Text("Expires in "
                          "${widget.chatMessage.expires_in!.difference(
                          DateTime.now()
                      ).inSeconds
                      }"
                          +
                          " seconds"
                        ,style: _const.manrope_regularwhite (13 , FontWeight.w800),)
                      ,
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
class TimeRequestChatMessage{
  String message;
  DateTime ? time;
  SchedulePickupTime ? picuptime;
  String ?status;
  DateTime ?expires_in;
  MessageType type;
  TimeRequestChatMessage({required this.message,required this.type,required this.picuptime,
    required
    this.expires_in,
    required
    this.status,
  required this.time
  });
}
