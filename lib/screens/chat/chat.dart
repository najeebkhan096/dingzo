import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/model/chat_reciver.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/order.dart';
import 'package:dingzo/screens/chat/TimeRequestChatBubble.dart';
import 'package:dingzo/screens/chat/chat_bubble.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat_Screen extends StatefulWidget {


  static const routename = "Chat_Screen";
  static const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    border: InputBorder.none,
  );

  @override
  State<Chat_Screen> createState() => _Chat_ScreenState();
}

class _Chat_ScreenState extends State<Chat_Screen> with WidgetsBindingObserver {
  TextEditingController message = TextEditingController();

  Constants _const=Constants();



  void _showErrorDialog(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: (ctx) =>Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width*0.65,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

              ),
              child: Column(
                children: [
                  Container(
                    height: height*0.27,
                    width: width*0.65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20)),

                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage("https://tse4.mm.bing.net/th?id=OIP.9eSLzTejcVBWh5qDTnpSuAHaHa&pid=Api&P=0&w=152&h=152")
                        )
                    ),
                  ),

                  Container(
                      width: width*0.65,
                      alignment: Alignment.center,
                      height: height*0.08,
                      color: Color(0xffFFEA9D),
                      child: Text("You just got offer from radient...",style: _const.raleway_regular_darkbrown(17, FontWeight.w600),)),
                  Container(
                    width: width*0.65,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              height: height*0.055,
                              color: Colors.white,
                              child: Center(child: Text("\$12",style: _const.raleway_SemiBold_darkbrown(17, FontWeight.w600),)),
                            )),

                        Expanded(
                            flex: 3,
                            child: Container(
                              height: height*0.055,
                              color: Color(0xff48C655),
                              child: Container(
                                  child: Center(child: Text("Accept",style: _const.raleway_SemiBold_white(16, FontWeight.w600),))),
                            ))

                      ],
                    ),
                  ),

                  Container(
                    width: width*0.65,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                              height: height*0.055,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20)),
                                color: Colors.red,
                              ),
                              child: Container(
                                  child: Center(child: Text("Decline",style: _const.raleway_SemiBold_white(16, FontWeight.w600),))),
                            )),
                        Expanded(

                            child: Container(
                              height: height*0.055,

                              decoration: BoxDecoration(
                                color: Color(0xffEFB546),
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),

                              ),
                              child: Container(
                                  child: Center(child: Text("Counter",style: _const.raleway_SemiBold_white(16, FontWeight.w600),))),
                            ))
                      ],
                    ),
                  )


                ],
              ),
            ),
          ],
        ));
  }


  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          return new Container(

            color: Color(0xffFFEA9D),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Text("Make a counter-offer",
                    style: _const.raleway_regular_darkbrown(
                        25, FontWeight.w700)),

                SizedBox(
                  height: height * 0.02,
                ),
                Text("Your Offer",
                    style: _const.raleway_regular_darkbrown(
                        20, FontWeight.w700)),

                SizedBox(
                  height: height * 0.03,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: width*0.05,right: width*0.05,top: height*0.015,bottom:  height*0.015),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("\$22",textAlign: TextAlign.center,style: _const.raleway_SemiBold_brown(15, FontWeight.w700),)),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                Text("Your Message",
                    style: _const.raleway_regular_darkbrown(
                        20, FontWeight.w700))
                ,
                SizedBox(
                  height: height * 0.025,
                ),

                Container(
                  height: height*0.15,
                  width: width*1,
                  margin: EdgeInsets.only(left: width*0.05,right: width*0.05,),

                  padding: EdgeInsets.only(top: height*0.025,),

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("I want this",textAlign: TextAlign.center,style: _const.raleway_SemiBold_brown(15, FontWeight.w700),),
                ),




                SizedBox(height: height*0.045,),
                InkWell(
                  onTap: (){

                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Container(
                      height: height*0.05,
                      width: width*0.25,
                      padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                      decoration: BoxDecoration(
                          color: Color(0xffEFB546),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text("Done",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                    ),
                  ),
                ),
              ],

            ),
          );
        }
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    message.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
   WidgetsBinding.instance.addObserver(this);
  }


  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed){
      await database.update_online_status(status: true);




    }

    else{
     await  database.update_online_status(status: false);

    }

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ChatReciever chat_reciever= ModalRoute.of(context)!.settings.arguments as ChatReciever;


    return Scaffold(
      backgroundColor: Colors.white,
      body: //body
      Container(
        height: height*1,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Container(
              height: height*0.1,
              width: width*1,
              color: Colors.white,
              margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    margin: EdgeInsets.only(left: width*0.05,right: width*0.025),
                    child: IconButton(onPressed: (){
                      Navigator.of(context).pop();

                    }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
                  ),



                  Container(
                    width: width*0.6,
                    child: ListTile(

                        leading:
                            chat_reciever.user!.uid=="admin"?
                            CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage("https://d2gg9evh47fn9z.cloudfront.net/1600px_COLOURBOX9896883.jpg")
                            )
                                :
                        (chat_reciever.user!.imageurl==null || chat_reciever.user!.imageurl!.isEmpty )?
                        CircleAvatar(
                          radius: 20,
                          child: Center(child: Text("No image",style: TextStyle(fontSize: 7),)),
                        ):  CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(chat_reciever.user!.imageurl!.toString())
                        )
                        ,
                        title: Text(chat_reciever.user!.username.toString(),
                          style: _const.manrope_regular263238(14, FontWeight.w600),
                        ),
                        subtitle:
                        chat_reciever.user!.uid=='admin'?
                        Text(
                          "Online now"
                          ,
                          style:TextStyle(
                              color: Color(0xff607D8B),
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),
                        ) :
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance.collection('Users').doc(chat_reciever.user!.doc!).snapshots(),
                          builder: (context,status_snaps){
                            if(status_snaps.connectionState==ConnectionState.waiting)
                               { return Text("");}
                            else if(status_snaps.hasData){
                              Map ?targetuser;
                              print("lund "+chat_reciever.user!.uid.toString());
                              if(chat_reciever.user!.uid=='admin'){
                                targetuser={'online':true};
                              }
                              else{
                                targetuser=status_snaps.data!.data() as Map;
                              }



                              if(targetuser['online']){
                                return   Text(
                                  "Online now"
                                  ,
                                  style:TextStyle(
                                      color: Color(0xff607D8B),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400
                                  ),
                                );
                              }
                              else {
                                return   Text(
                                  "Offline now"
                                  ,
                                  style:TextStyle(
                                      color: Color(0xff607D8B),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400
                                  ),
                                );
                              }
                            }else{
                              return  Text("");
                            }

                          },
                        )



                    ),
                  ),
Text("")
                ],
              ),
            ),

            Card(
              color: Colors.white,
              elevation: 10,
              child: Container(
                margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                padding: EdgeInsets.all(10),
                child:   Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: width*0.1,right: width*0.025),
                      width: width*0.3,
                      height: height*0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(chat_reciever.product!.photos![0])
                          )
                      ),
                    ),

                    Container(
                      width: width*0.3,
                      margin: EdgeInsets.only(left: width*0.05,right: width*0.025),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(chat_reciever.product!.title!,style: _const.poppin_Regualr_2C2C2C(13, FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: height*0.01,),
                          Text("\$${chat_reciever.product!.price}",style: _const.poppin_Regualr_2C2C2C(13, FontWeight.w600)),


                        ],
                      ),
                    ),




                  ],
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),


            //chat screen

            Expanded(
              child: Container(

                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.
                    collection("chatRoom")
                        .doc(chat_reciever.chatid)
                        .collection("chats")
                        .orderBy('time')
                        .snapshots(),
                    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                      return snapshot.hasData?

                      ListView(

                        children: List.generate(snapshot.data!.docs.length, (index) {
                          bool  ?timechange;
                          DateTime ? expires_in;
                          String ? status;
                          DateTime ? pickupdate;
                          try{
                            status=snapshot.data!.docs[index]['status'];
                            Timestamp stamp = snapshot.data!.docs[index]['expires_in'];
                            expires_in=stamp.toDate();

                            Timestamp pickupstamp = snapshot.data!.docs[index]['pickup_time']['date'];
                           pickupdate= pickupstamp.toDate();

                            timechange=true;

                          }catch(error){
                            print("ali baba ");
                            timechange=false;
                          }

                          return   timechange==false?

                          ChatBubble(
                            chatMessage: ChatMessage(
                                userimage: '',
                                message: snapshot.data!.docs[index]['message'],
                                type:
                                snapshot.data!.docs[index]['SendBy']==user_id?
                                MessageType.Sender
                                    :
                                MessageType.Receiver

                            ),
                          ):
                          TimeRequestChatBubble(
                            order_id: chat_reciever.product!.order_id,
                            chatid: chat_reciever.chatid,
                            docid: snapshot.data!.docs[index].id,
                            chatMessage: TimeRequestChatMessage(

                            expires_in: expires_in,

                                time: DateTime.fromMillisecondsSinceEpoch(snapshot.data!.docs[index]['time']),
                                status: status,
                                picuptime: SchedulePickupTime(date: pickupdate, time: snapshot.data!.docs[index]['pickup_time']['time']),
                                message: "Hello, unfortunatly I am not available at that date could you pick it up at this date instead? Thank you!",
                                type:
                                snapshot.data!.docs[index]['SendBy']==user_id?
                                MessageType.Sender
                                    :
                                MessageType.Receiver

                            ),
                          );
                        }
                        ),
                      )

                          :Text("no data");
                    }),
              ),
            ),

            Container(
             height: height*0.1,

              child: Row(
                children: [

                  Container(
                    width: width*0.83,
                    child: Card(
                      color: Color(0xffECEFF1),
                      margin: EdgeInsets.only(
                          left: width * 0.075, right: width * 0.025),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: width * 0.5,
                            child: TextField(
                                controller: message,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    helperStyle: TextStyle(
                                      color: Color(0xff78909C),
                                      fontSize: 14,
                                      fontFamily: 'Manrope-Regular'
                                    ),
                                    hintText: "Type your text..",
                                    contentPadding: EdgeInsets.only(left: 20))),
                          ),
                          InkWell(
                              onTap: () {

                              },
                              child: Icon(
                                Icons.attach_file,
                                color: Color(0xff546E7A),
                              ))
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: ()async{
                      SocialMediaDatabase _socila_database=SocialMediaDatabase();


                      if(chat_reciever.user!.uid=='admin'){

                      }
                      else{
                        await _socila_database.sendPushMessage(title: 'You have new message', body: message.text,
                            token: chat_reciever.user!.deviceid);

                      }

                     await  _socila_database.addMessage(
                          chatRoomId: chat_reciever.chatid,
                          chatMessageData: {
                            'message': message.text,
                            'SendBy': user_id,
                            'time':DateTime.now().millisecondsSinceEpoch
                          }).then((value) {
                        message.clear();
                      });





                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffE6FCF5)
                        ),
                        child: Icon(Icons.send,color: mycolor,)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
