import 'package:dingzo/hometesting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dingzo/Address/set_up_address.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/SelectCategory.dart';
import 'package:dingzo/screens/SellItem.dart';
import 'package:dingzo/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FinishScreen extends StatefulWidget {
  static const routename="FinishScreen";
  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  Constants _const=Constants();

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _switch=false;
  String ? name='';

  String ? email='';

  String ? pass='';

  bool  show=false;
  bool continue_button=false;
  List categ=['Men','Women','Beauty','Hobby'];
bool fetched=false;
  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
if(fetched==false){
  await database.fetchprofiledata(DesiredUserID: user_id).then((value) async {
    currentuser = value;
  setState(() {
    fetched=true;
  });
  }
  );
}

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: Colors.white,
      body:

      fetched==false?
          SpinKitCircle(
            color: mycolor,
          )
          :
      Container(

        child: ListView(
          children: [
            Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                },
                  icon: Icon(Icons.arrow_back,
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                    size: 18,),
                ),

                Text("")
              ],
            ),

            SizedBox(height: height*0.03,),

            Center(child: Container(

                child: Text("Welcome!",style: _const.poppin_SemiBold(25, FontWeight.w600),)
            )),
            SizedBox(height: height*0.075,),
            Center(child: Container(
              width: width*0.7,
                child: Text("Thanks for joining the Zarkit community! Sell or rent almost anything and make some quick cash?",style: _const.poppin_SemiBold(20, FontWeight.w600),
                textAlign: TextAlign.center,
                ))),
            SizedBox(height: height*0.075,),
      Container(
        margin: EdgeInsets.only(left: width*0.15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                if(currentuser!.home_address!.isEmpty){
                  Navigator.of(context).pushNamed(Set_up_Address.routename);
                }
                else{
                  Navigator.of(context).pushNamed(SellItem.routename);
                }


              },
              child: Container(
            height: height*0.055,
            width: width*0.4,


            decoration: BoxDecoration(
              color: blackbutton,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                  'Rent Now',
                  style: _const.poppin_white(16, FontWeight.w600)
              ),
            ),
              ),
            ),


            SizedBox(width: width*0.025,),
            CircleAvatar(
              radius: 20,
              backgroundColor: mycolor,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(Icons.question_mark,color: mycolor),
              ),
            )


          ],
        ),
      )
            ,
            SizedBox(height: height*0.025,),
            Container(
              margin: EdgeInsets.only(left: width*0.15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      if(currentuser!.home_address!.isEmpty){
                        Navigator.of(context).pushNamed(Set_up_Address.routename);
                      }
                      else{
                        Navigator.of(context).pushNamed(SellItem.routename);
                      }


                    },
                    child: Container(
                      height: height*0.055,
width: width*0.4,
                      // margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.25,right: MediaQuery.of(context).size.width*0.25,),

                      decoration: BoxDecoration(
                        color: blackbutton,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                            'Sell Now',
                            style: _const.poppin_white(16, FontWeight.w600)
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: width*0.025,),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: mycolor,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                    child: Icon(Icons.question_mark,color: mycolor),
                    ),
                  )

                ],
              ),
            ),
            SizedBox(height: height*0.05,),
            Center(child: Container(
                width: width*0.7,
                child: Text("I’m looking for an item instead.",style: _const.poppin_SemiBold(20, FontWeight.w600),
                textAlign: TextAlign.center,
                ))),

            SizedBox(height: height*0.025,),
            continue_button?
        SpinKitCircle(color:mycolor)
        :
            InkWell(
              onTap: (){

                try{
                  setState(() {
                    continue_button=true;
                  });
                  if(currentuser!.home_address!.length==0){
                    setState(() {
                      continue_button=false;
                    });
                    Navigator.of(context).pushNamed(Set_up_Address.routename);
                  }
                  else{
                    Navigator.of(context).pushNamed(HomeTesting.routename);
                  }

                }catch(error){
print("error is "+error.toString());
                }

              },
              child: Center(
                child: Container(
                  height: height*0.055,
                  width: width*0.4,

                  decoration: BoxDecoration(
                    color: blackbutton,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                        'Continue',
                        style: _const.poppin_white(16, FontWeight.w600)
                    ),
                  ),
                ),
              ),
            )


          ],
        ),
      ),

    );
  }
}
