import 'package:dingzo/constants.dart';
import 'package:dingzo/model/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Nagatiate_Pickup_Time extends StatefulWidget {
  final Order?  current_order;
  Nagatiate_Pickup_Time({this.current_order});

  @override
  State<Nagatiate_Pickup_Time> createState() => _Nagatiate_Pickup_TimeState();
}



class _Nagatiate_Pickup_TimeState extends State<Nagatiate_Pickup_Time> {

  double final_total=0;

  final GlobalKey<FormState> _formKey = GlobalKey();
  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occured'),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ));
  }
  DateTime today_date=DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day+1);
  TextEditingController date_time_controller=TextEditingController();
  TextEditingController?  comment_controller=TextEditingController();
  String today_date_text='';
String ? pickuptime='';
  String notes = '';

  TimeOfDay ? selecyed_time=TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
SchedulePickupTime ? pickup_time;
  String _hour='0';

  String _minutes='0';

  Constants _const=Constants();

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    date_time_controller.dispose();
    comment_controller!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
 return Scaffold(
   backgroundColor: Colors.white,
   appBar: AppBar(
     elevation: 0.8,
     leadingWidth: width*0.3
     ,
     backgroundColor: Colors.white,
     centerTitle: false,
     title: Text("Negotiate Pickup time",style: _const.manrope_regular263238(20, FontWeight.w800)),
     leading: IconButton(onPressed: (){
       Navigator.of(context).pop();

     }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),


   ),
   body: ListView(
     children: [

       SizedBox(height: height*0.02,),

       Container(
         margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
         child:   Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Container(
               width: width*0.3,
               height: height*0.145,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   image: DecorationImage(
                       fit: BoxFit.values[2],
                       image: NetworkImage(widget.current_order!.products![0].photos![0])
                   )
               ),
             ),

             Expanded(

               child: Container(
                 margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(widget.current_order!.products![0].title!,style: _const.raleway_263238(20, FontWeight.w600)),
                         Text("\$${widget.current_order!.products![0].price!}",style: _const.raleway_263238(15, FontWeight.w600)),

                       ],
                     ),

                     SizedBox(height: height*0.015,),
                     Text("Order ID: ${widget.current_order!.order_id!}",style: _const.raleway_263238(15, FontWeight.w600)),
                     SizedBox(height: height*0.015,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           height: height*0.04,
                           width: width*0.25,
                           padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                           decoration: BoxDecoration(
                               color: mycolor,
                               borderRadius: BorderRadius.circular(10)
                           ),
                           child: Center(child: Text("View Order",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                         ),

                         Container(
                           height: height*0.04,
                           width: width*0.25,
                           padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                           decoration: BoxDecoration(
                               color: mycolor,
                               borderRadius: BorderRadius.circular(10)
                           ),
                           child: Center(child: Text("View Reciept",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                         ),
                       ],
                     ),

                   ],
                 ),
               ),
             ),





           ],
         ),
       ),
       SizedBox(height: height*0.01,),
       Divider(),
       SizedBox(height: height*0.01,),
       Container(
         margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
         child: Row(
           children: [

             Expanded(
                 child: Column(

                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [


                     Container(
                         margin: EdgeInsets.only(left: width*0.025),
                         child: Text("Date",style: _const.manrope_regular546E7A(12 , FontWeight.w600 ),)),

                     SizedBox(height: height*0.01,),

                      InkWell(
                        onTap: (){
                          showDatePicker(
                              context: context,

                              initialDate: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day+1),

                              firstDate:  DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day+1),
                              lastDate: DateTime(2023)

                          )
                              .then((date) {
                            setState(() {

                              date_time_controller.text=today_date.toString();
                            });
                            today_date=date!;
                          });
                        },
                        child: Container(
                          height: height*0.063,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffECEFF1)
                          ),
                          child: Row(

                            children: [
                   SizedBox(width: width*0.025,),
                              Icon(Icons.date_range,color: Color(0xff78909C),),
                              SizedBox(width: width*0.025,),
                              Text(DateFormat.yMd().format(today_date),
                             maxLines: 1,
                             style:  _const.manrope_regular78909C(14  , FontWeight.w400 ),
                              )
                            ],
                          )


                        ),
                      )

             ],)),
            SizedBox(width: width*0.025,),
             Expanded(
                 child: Column(

                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     Container(
                         margin: EdgeInsets.only(left: width*0.025),
                         child: Text("Time",style: _const.manrope_regular546E7A(12 , FontWeight.w600 ),)),
                     SizedBox(height: height*0.01,),
                     InkWell(
                       onTap: ()async{

                         TimeOfDay ? data= await showTimePicker(context: context, initialTime: selecyed_time!);
                       if(data!=null){
                         selecyed_time=data;
                         print("amna"+selecyed_time.toString());
                         // Conversion logic starts here
                         DateTime tempDate = DateFormat("hh:mm").parse(
                             selecyed_time!.hour.toString() +
                                 ":" + selecyed_time!.minute.toString());
                         var dateFormat = DateFormat("h:mm a"); // you can change the format here
                         print("rimsha "+dateFormat.format(tempDate));

                         setState((){
                           pickuptime= dateFormat.format(tempDate);
                         });
                       }
                       },
                       child: Container(
                           height: height*0.063,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               color: Color(0xffECEFF1)
                           ),
                           child: Row(

                             children: [
                               SizedBox(width: width*0.025,),
                               Icon(Icons.watch_later,color: Color(0xff78909C),),
                               SizedBox(width: width*0.025,),
                            pickuptime!.isNotEmpty?
                            Text(pickuptime.toString(),
                              style:  _const.manrope_regular78909C(14  , FontWeight.w400 ),
                            ):
                               Text("Select time",
                                 style:  _const.manrope_regular78909C(14  , FontWeight.w400 ),
                               )
                             ],
                           )


                       ),
                     )

                   ],)),

           ],
         ),
       ),
       SizedBox(height: height*0.05,),

       Padding(
         padding: const EdgeInsets.only(left: 15.0,right: 10,bottom: 10,top: 10),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(height: 10,),
             Text(DateFormat.yMMMMEEEEd().format(today_date),style: TextStyle(fontSize: 25),),
             Text(pickuptime!,style: TextStyle(fontSize: 25),),


           ],
         ),
       ),

       SizedBox(height: height*0.01,),

       Container(
           margin: EdgeInsets.only(left: width*0.025),
           child: Text("Message to Seller (optional)",style: _const.manrope_regular546E7A(12 , FontWeight.w600 ),)),
       SizedBox(height: height*0.01,),
       Container(
         margin: EdgeInsets.only(left: width*0.025,right: width*0.025),
         padding: EdgeInsets.only(left: width*0.025,right: width*0.025),
         height: height*0.2,
         decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
             color: Color(0xffECEFF1)
         ),
         child: TextField(
           controller: comment_controller,
           decoration: InputDecoration(
               border: InputBorder.none,
               hintText: "Hello, can I pickup this charger at this time? Thank you!",
               hintStyle: _const.manrope_regular78909C(14  , FontWeight.w400 ),

           ),


         ),
       ),
       SizedBox(height: height*0.02,),

       InkWell(
         onTap: (){
           if(pickuptime!.isNotEmpty){
             Navigator.pop(context,  SchedulePickupTime(date: today_date, time: pickuptime!,comment: comment_controller!.text));
           }

           else{
             _showErrorDialog("Please Select Pickup Time");
           }
         },
         child: Container(
           height: height * 0.055,
           width: width * 1,
           margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),

           padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
           decoration: BoxDecoration(
               color:mycolor,
               borderRadius: BorderRadius.circular(10)
           ),
           child: Center(child: Text("Confirm Time",
             style: _const.raleway_SemiBold_white(16, FontWeight.w600),)),
         ),
       ),
       SizedBox(height: height*0.02,),
       Center(
         child: InkWell(
           onTap: (){



            },
           child: Container(
             height: height * 0.055,
             width: width * 0.3,
             margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),

             padding: EdgeInsets.only(left: width * 0.02, right: width * 0.02),
             decoration: BoxDecoration(
                 color:mycolor,
                 borderRadius: BorderRadius.circular(10)
             ),
             child: Center(child: Text("Help",
               style: _const.raleway_SemiBold_white(16, FontWeight.w600),)),
           ),
         ),
       ),


     ],
   ),
 );
  }
}
