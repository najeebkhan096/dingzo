import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
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

class _Chat_ScreenState extends State<Chat_Screen> {
  TextEditingController message = TextEditingController();

  Constants _const=Constants();
  List<ChatMessage> messages_list=[
    ChatMessage(message: "Hi",type: MessageType.Sender,userimage: "https://tse1.mm.bing.net/th?id=OIP.23gnJYIxRYyTnacDs2mUXQHaHa&pid=Api&P=0&w=176&h=176"),
    ChatMessage(message: "Hello",type: MessageType.Receiver,userimage: "https://tse1.mm.bing.net/th?id=OIP.23gnJYIxRYyTnacDs2mUXQHaHa&pid=Api&P=0&w=176&h=176"),
    ChatMessage(message: "How are you?",type: MessageType.Sender,userimage: "https://tse1.mm.bing.net/th?id=OIP.23gnJYIxRYyTnacDs2mUXQHaHa&pid=Api&P=0&w=176&h=176"),
    ChatMessage(message: "Fine",type: MessageType.Receiver,userimage: "https://tse1.mm.bing.net/th?id=OIP.23gnJYIxRYyTnacDs2mUXQHaHa&pid=Api&P=0&w=176&h=176"),
  ];
  String chatid = '';

  MyUser? user;


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
   current_index=3;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("step1");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final List data= ModalRoute.of(context)!.settings.arguments as List;
    try{
      chatid=data[0];
      user=data[1];

    }catch(error){

    }

    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: //body
      ListView(
        children: [
    Container(
      height: height*0.86,
      child: ListView(

        children: [
          //appbar
          Container(
            height: height*0.15,
            width: width*1,
            decoration: BoxDecoration(
                color:  Color(0xffFFEA9D),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))
            ),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: height*0.025,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child:SvgPicture.asset('images/back.svg',height: height*0.025,)
                      ),
                    ),

                    Text(user!.username.toString(),style: _const.raleway_extrabold(30, FontWeight.w800),),


                    InkWell(
                        onTap: (){
                          _showErrorDialog(context);
                        },
                        child: Image.asset('images/cart.png',))
                  ],
                ),

                SizedBox(height: height*0.03,),
              ],
            ),

          ),


          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),

          //drawer row

          //chat screen

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance.
                  collection("chatRoom")
                      .doc(chatid)
                      .collection("chats")
                      .orderBy('time')
                      .snapshots(),
                  builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                    return snapshot.hasData?

                    Container(

                      height: height * 0.445,
                      width: width * 1,
                      margin: EdgeInsets.only(
                          left: width * 0.02,
                          right: width * 0.02,
                          top: width * 0.02,
                          bottom: width * 0.02),
                      child: SingleChildScrollView(
                        child: Column(

                          children: List.generate(snapshot.data!.docs.length, (index) =>
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
                              )
                          ),
                        ),
                      ),
                    )

                        :Text("no data");
                  }),


            ],
          ),

        ],
      ),
    ),

          Card(
            color: Color(0xffFFEA9D),
            margin: EdgeInsets.only(
                left: width * 0.05, right: width * 0.05),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
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
                          hintText: "Write a message here",
                          contentPadding: EdgeInsets.only(left: 20))),
                ),
                InkWell(
                    onTap: () {
                      SocialMediaDatabase _database=SocialMediaDatabase();
                      _database.addMessage(
                          chatRoomId: chatid,
                          chatMessageData: {
                            'message': message.text,
                            'SendBy': user_id,
                            'time':DateTime.now().millisecondsSinceEpoch
                          }).then((value) {
                        message.clear();
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Color(0xff8B6824),
                      child: Image.asset('images/send.png'),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
