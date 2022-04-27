import 'package:dingzo/constants.dart';
import 'package:flutter/material.dart';
class ChatBubble extends StatefulWidget{
  ChatMessage chatMessage;
  ChatBubble({required this.chatMessage});
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  Constants _const=Constants();
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
      child: Align(
          alignment: (widget.chatMessage.type == MessageType.Receiver?Alignment.topLeft:Alignment.topRight),
          child: widget.chatMessage.type == MessageType.Receiver?
          Container(

            child: Row(
              children: [
              CircleAvatar(
                radius: 27,
                 backgroundImage: NetworkImage(widget.chatMessage.userimage.toString())
              ),
                Container(
                  margin: EdgeInsets.only(left: width*0.025),
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20),
                      color: Colors.white

                  ),
                  padding: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.025,top: height*0.025),
                  child: Text(widget.chatMessage.message.toString(),style: _const.raleway_semi_444444(13, FontWeight.w600)),

                ),
              ],
            ),
          ):

          Container(
            child: Row(
             mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: width*0.025),

                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20),
                      color: Color(0xffFFEA9D)

                  ),
                  padding: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.025,top: height*0.025),
                  child: Text(widget.chatMessage.message.toString(),style: _const.raleway_semi_444444(13, FontWeight.w600)),

                ),
                CircleAvatar(
                    radius: 27,
                    backgroundImage: NetworkImage(widget.chatMessage.userimage.toString())
                ),
              ],
            ),
          )
      ),
    );
  }
}
class ChatMessage{
  String message;
  String userimage;
  MessageType type;
  ChatMessage({required this.message,required this.type,required this.userimage});
}
enum MessageType{
  Sender,
  Receiver,
}