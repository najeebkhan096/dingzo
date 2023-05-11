import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/screens/editaddress.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class EditPayment extends StatefulWidget {
  static const routename="EditPayment";

  @override
  State<EditPayment> createState() => _EditPaymentState();
}

class _EditPaymentState extends State<EditPayment> {
  Constants _const = Constants();

  final GlobalKey<FormState> _formKey = GlobalKey();
bool edit=false;
  bool add_newcard=false;
  int selected_card_index=0;
  int selected_address_index=0;
bool isloading=false;
String ? firstname;
String ? lastname;
String ? cardnumber;
String ? ccv;

bool ? checkaddress=false;
Address ? selected_address;
Future<Address?> _showModalSheet(BuildContext context)async {

   await  showModalBottomSheet(
        context: context,
        builder: (builder) {
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;
          return  StatefulBuilder(builder: (context,setState){
            return Container(

              color:  Color(0xffBCEFE0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.025,),
                  Center(child: Text("Select Address",style: _const.raleway_263238(25, FontWeight.w700),))
                  ,
                  SizedBox(height: height*0.05,),
                  Column(
                    children: List.generate(checkhout_addresses.length, (index) =>   Container(
                      margin: EdgeInsets.only(left: width * 0.02),
                      child: Row(

                        children: [
                          Checkbox(
                            onChanged: (val){
                              print("step1");
                              setState(() {
                                checkhout_addresses[index].status=val;
                                if(val==true){
                                  selected_address_index=index;
                                }
                                for (int i=0;i<checkhout_addresses.length;i++){
                                  if(i!=index){
                                    print("step2");
                                    checkhout_addresses[i].status=false;
                                  }
                                }
                              });


                            }, value: checkhout_addresses[index].status,

                          ),

                          SizedBox(width: width*0.02,),
                          Container(
                              width: width * 0.45,
                              child: Text(
                                  checkhout_addresses[index].address!.firstname!.toString()+
                                      checkhout_addresses[index].address!.lastlast!+" "+
                                      " "+  checkhout_addresses[index].address!.address1.toString()+" "+
                                      checkhout_addresses[index].address!.address2.toString() +" "+
                                      checkhout_addresses[index].address!.city.toString() +" "+
                                      checkhout_addresses[index].address!.state.toString() +" "+
                                      checkhout_addresses[index].address!.zipcode.toString() ,
                                  style: _const.raleway_535F5B(
                                      15, FontWeight.w600))),
                          InkWell(
                            onTap: (){
                              if(checkhout_addresses[index].status!){
                                setState(() {
                                  edit=true;
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: rgbcolor,
                                  borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.only(
                                  left: width * 0.03,
                                  right: width * 0.03,
                                  bottom: height * 0.01,
                                  top: height * 0.01),
                              child: Text("Edit",
                                style: _const.raleway_535F5B(15, FontWeight.w600),
                              ),
                            ),)
                        ],
                      ),
                    ),),
                  ),


                  SizedBox(height: height*0.045,),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(EditAddress.routename);

                    },
                    child: Center(
                      child: Container(
                        height: height*0.055,
                        width: width*1,
                        margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                        decoration: BoxDecoration(
                            color: blackbutton,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text("Add new Address",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.045,),
                  InkWell(
                    onTap: (){
                    checkhout_addresses.forEach((element) {
                      if(element.status==true){
                        newaddress=element.address;
                        Navigator.pop(context,newaddress);
                      }

                    });

                    },
                    child: Center(
                      child: Container(
                        height: height*0.055,
                        width: width*1,
                        margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                        decoration: BoxDecoration(
                            color: blackbutton,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text("Submit Address",style:_const.raleway_SemiBold_white(12, FontWeight.w600),)),
                      ),
                    ),
                  ),
                ],

              ),
            );
          });
        }
    );
  }
  String? _showErrorDialog(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Alert'),
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
  Future<void> _editsubmit() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      isloading=true;
    });
    currentuser!.paymentmethod![selected_card_index]=checkhout_cards[selected_card_index].payment!;
    setState(() {
      edit=false;
      isloading=false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Card is Edited"))
      );


  }
  Address ? newaddress;
  Future<void> _submit() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    if(newaddress==null){
_showErrorDialog(context, "Please Provide Address") ;
    }
    else{
      setState(() {
        isloading=true;
      });
      currentuser!.paymentmethod!.add(
          Payment(
              cardnumber: cardnumber.toString(),
              address: newaddress,
              cvv: ccv,
              firstname: firstname.toString(),
              lastlast: lastname.toString(),
              city: ccv.toString()
          ));
      await  database.addUserpayment(updateduser: currentuser).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("New Payment Method is added"))
        );
        Navigator.of(context).pop();
      });

    }
  }
  @override
  void initState() {
    // TODO: implement initState
   get_new_checkhout_cards();
   get_new_checkhout_addresses();
    super.initState();
  }
  void get_new_checkhout_cards(){
    currentuser!.paymentmethod!.forEach((element) {
      checkhout_cards.add(CheckPayment(payment: element, status: false));
    });
  }
  void get_new_checkhout_addresses(){
    currentuser!.home_address!.forEach((element) {
      checkhout_addresses.add(CheckAddress(address: element, status: false));
    });
  }
  List<CheckPayment> checkhout_cards=[];
  List<CheckAddress> checkhout_addresses=[];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.8,

          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("My Payment Method",style: _const.manrope_regular263238(20, FontWeight.w800)),

          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();

          }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
          actions: [

          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [

            SizedBox(
              height: height * 0.05,
            ),
            Center(
              child: Text("Select Payment Method",
                  style: _const.raleway_535F5B(20, FontWeight.w600)),
            ),
            SizedBox(
              height: height * 0.025,
            ),
          Column(
             children: List.generate(checkhout_cards.length, (index) =>   Container(
               margin: EdgeInsets.only(left: width * 0.02),
               child: Row(

                 children: [
                   Checkbox(
                     onChanged: (val){
print("step1");
                       setState(() {
                         checkhout_cards[index].status=val;
                         if(val==true){
                           selected_card_index=index;
                         }
                         for (int i=0;i<checkhout_cards.length;i++){
                           if(i!=index){
                             print("step2");
                             checkhout_cards[i].status=false;
                           }
                         }
                       });


                     }, value: checkhout_cards[index].status,

                   ),
                   Image.asset('images/visa.png'),
                   SizedBox(width: width*0.02,),
                   Container(
                       width: width * 0.45,
                       child: Text(
                      checkhout_cards[index].payment!.cardnumber!.toString()+  checkhout_cards[index].payment!.address!.firstname.toString()+" "+checkhout_cards[index].payment!.address!.lastlast.toString()+" "+checkhout_cards[index].payment!.address!.address1.toString()+" "+checkhout_cards[index].payment!.address!.address2.toString() +" "+checkhout_cards[index].payment!.address!.city.toString() +" "+checkhout_cards[index].payment!.address!.state.toString() +" "+checkhout_cards[index].payment!.address!.zipcode.toString() ,
                           style: _const.raleway_535F5B(
                               15, FontWeight.w600))),
                   InkWell(
                     onTap: (){
                      if(checkhout_cards[index].status!){
                        setState(() {
                          edit=true;
                        });
                      }
                     },
                     child: Container(
                       decoration: BoxDecoration(
                           color: rgbcolor,
                           borderRadius: BorderRadius.circular(20)),
                       padding: EdgeInsets.only(
                           left: width * 0.03,
                           right: width * 0.03,
                           bottom: height * 0.01,
                           top: height * 0.01),
                       child: Text("Edit",
                           style: _const.raleway_535F5B(15, FontWeight.w600),
                     ),
                   ),)
                 ],
               ),
             ),),
          ),

            SizedBox(
              height: height * 0.025,
            ),
            Divider(),

            SizedBox(
              height: height * 0.025,
            ),

            InkWell(
              onTap: (){
                setState(() {
                  add_newcard=true;

                });
              },
              child: Container(
                height: height*0.055,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                decoration: BoxDecoration(
                    color: blackbutton,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Add New Card",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
              ),
            ),
            SizedBox(
              height: height * 0.025,
            ),

            if(edit)
            Form(
              key: _formKey,
              child: Container(
                width: width * 1,
                color: Color(0xffBCEFE0),
                padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: Column(
                  children: [


                    SizedBox(height: height*0.025,),
                    Text(
                      "Edit Card",
                      style:
                      _const.raleway_535F5B(25, FontWeight.w700),
                    ),
                    SizedBox(height: height*0.025,),


                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text("Full Name",
                              style: _const.raleway_535F5B(
                                  19, FontWeight.w700)),
                        ),
                        Container(
                          width: width * 0.285,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            initialValue: checkhout_cards[selected_card_index].payment!.firstname,

                            onSaved: (val){
                              // currentuser!.paymentmethod![0].firstname=val;
                              checkhout_cards[selected_card_index].payment!.firstname=val;
                            },
                            onChanged: (val){
                              checkhout_cards[selected_card_index].payment!.firstname=val;
                              //fi currentuser!.paymentmethod![0].firstname=val;

                            },
                            textAlign: TextAlign.center,
                            // initialValue:   currentuser!.paymentmethod![0].firstname,
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                            style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                          height: height * 0.055,
                        ),
                        SizedBox(width: width*0.025,),
                        Container(
                          width: width * 0.285,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            initialValue: checkhout_cards[selected_card_index].payment!.lastlast,
                            onSaved: (val){
                              // currentuser!.paymentmethod![0].firstname=val;
                              checkhout_cards[selected_card_index].payment!.lastlast=val;
                            },
                            onChanged: (val){
                              checkhout_cards[selected_card_index].payment!.lastlast=val;
                              //fi currentuser!.paymentmethod![0].firstname=val;

                            },
                            textAlign: TextAlign.center,
                            // initialValue:   currentuser!.paymentmethod![0].firstname,
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                            style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                          height: height * 0.055,
                        )
                      ],
                    ),

                    SizedBox(height: height*0.025,),
                    Row(
                      children: [
                        Container(
                          width: width * 0.35,
                          child: Text("Card Number :",
                              style: _const.raleway_535F5B(
                                  19, FontWeight.w700)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: width*0.05),
                          width: width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            initialValue: checkhout_cards[selected_card_index].payment!.cardnumber,
                            keyboardType: TextInputType.number,
                            onSaved: (val){
                              checkhout_cards[selected_card_index].payment!.cardnumber=val;
                              // currentuser!.paymentmethod![0].cardnumber=val;
                            },
                            onChanged: (val){
                              checkhout_cards[selected_card_index].payment!.cardnumber=val;
                              // currentuser!.paymentmethod![0].cardnumber=val;

                            },
                            textAlign: TextAlign.center,
                            // initialValue:   currentuser!.paymentmethod![0].cardnumber,
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                            style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                          height: height * 0.055,
                        )
                      ],
                    ),



                    SizedBox(height: height*0.025,),
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text("CCV:",
                              style: _const.raleway_535F5B(
                                  19, FontWeight.w700)),
                        ),
                        Container(
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            initialValue: checkhout_cards[selected_card_index].payment!.cvv,
                            onSaved: (val){
                              checkhout_cards[selected_card_index].payment!.cvv=val;
                              // currentuser!.paymentmethod![0].city=val;
                            },
                            onChanged: (val){
                              checkhout_cards[selected_card_index].payment!.cvv=val;
                              // currentuser!.paymentmethod![0].city=val;

                            },
                            textAlign: TextAlign.center,
                            // initialValue:   currentuser!.paymentmethod![0].city,
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                            style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                          height: height * 0.055,
                        )
                      ],
                    ),

                    SizedBox(height: height*0.025,),
                    Row(
                      children: [
                        Container(
                          width: width * 0.3,
                          child: Text("Address :",
                              style: _const.raleway_535F5B(
                                  19, FontWeight.w700)),
                        ),
                        SizedBox(width: width*0.025,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            InkWell(
                              onTap: (){
                                _showModalSheet(context);
                              },
                              child: CircleAvatar(
                               radius: 12,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.add,size: 14,color: Color(0xffEFB546)),
                              ),
                            ),


                            SizedBox(width: width*0.025,),

                            Text("Add Address",style:_const.raleway_SemiBold_white(16, FontWeight.w600),),

                          ],
                        ),

                      ],
                    ),


                    SizedBox(height: height*0.05,),
                    isloading?SpinKitRotatingCircle(
                      color: Colors.black,
                      size: 50.0,
                    ):
                    InkWell(
                      onTap: ()async{
                    _editsubmit();
                      },
                      child: Container(
                        height: height*0.055,
                        width: width*1,
                        margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                        padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                        decoration: BoxDecoration(
                            color: blackbutton,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text("Edit Card",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                      ),
                    ),
                    SizedBox(height: height*0.05,),

                  ],
                ),
              ),
            ),
            if(add_newcard)
              Form(
                key: _formKey,
                child: Container(
                  width: width * 1,
                  color: Color(0xffBCEFE0),
                  padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: Column(
                    children: [


                      SizedBox(height: height*0.025,),
                      Text(
                        "Add Card",
                        style:
                        _const.raleway_535F5B(25, FontWeight.w700),
                      ),
                      SizedBox(height: height*0.025,),


                      Row(
                        children: [
                          Container(
                            width: width * 0.3,
                            child: Text("Full Name",
                                style: _const.raleway_535F5B(
                                    19, FontWeight.w700)),
                          ),
                          Container(
                            width: width * 0.285,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: TextFormField(

                              onSaved: (val){
                                // currentuser!.paymentmethod![0].firstname=val;
                                firstname=val;
                              },
                              onChanged: (val){
                                firstname=val;
                                //fi currentuser!.paymentmethod![0].firstname=val;

                              },
                              textAlign: TextAlign.center,
                              // initialValue:   currentuser!.paymentmethod![0].firstname,
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                              style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                            height: height * 0.055,
                          ),
                          SizedBox(width: width*0.025,),
                          Container(
                            width: width * 0.285,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: TextFormField(
                              onSaved: (val){
                                // currentuser!.paymentmethod![0].firstname=val;
                                lastname=val;
                              },
                              onChanged: (val){
                                lastname=val;
                                //fi currentuser!.paymentmethod![0].firstname=val;

                              },
                              textAlign: TextAlign.center,
                              // initialValue:   currentuser!.paymentmethod![0].firstname,
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                              style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                            height: height * 0.055,
                          )
                        ],
                      ),

                      SizedBox(height: height*0.025,),
                      Row(
                        children: [
                          Container(
                            width: width * 0.35,
                            child: Text("Card Number :",
                                style: _const.raleway_535F5B(
                                    19, FontWeight.w700)),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width*0.05),
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onSaved: (val){
                                cardnumber=val;
                                // currentuser!.paymentmethod![0].cardnumber=val;
                              },
                              onChanged: (val){
                                cardnumber=val;
                                // currentuser!.paymentmethod![0].cardnumber=val;

                              },
                              textAlign: TextAlign.center,
                              // initialValue:   currentuser!.paymentmethod![0].cardnumber,
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                              style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                            height: height * 0.055,
                          )
                        ],
                      ),



                      SizedBox(height: height*0.025,),
                      Row(
                        children: [
                          Container(
                            width: width * 0.3,
                            child: Text("CCV:",
                                style: _const.raleway_535F5B(
                                    19, FontWeight.w700)),
                          ),
                          Container(
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: TextFormField(
                              onSaved: (val){
                                ccv=val;
                                // currentuser!.paymentmethod![0].city=val;
                              },
                              onChanged: (val){
                                ccv=val;
                                // currentuser!.paymentmethod![0].city=val;

                              },
                              textAlign: TextAlign.center,
                              // initialValue:   currentuser!.paymentmethod![0].city,
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                              style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                            height: height * 0.055,
                          )
                        ],
                      ),

                      SizedBox(height: height*0.025,),
                      Row(
                        children: [
                          Container(
                            width: width * 0.3,
                            child: Text("Address :",
                                style: _const.raleway_535F5B(
                                    19, FontWeight.w700)),
                          ),
                          SizedBox(width: width*0.025,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              InkWell(
                                onTap: ()async{
                                  print("lund");
                                 await  _showModalSheet(context).then((value) {

                                 });
                                },
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.add,size: 14,color: Color(0xffEFB546)),
                                ),
                              ),


                              SizedBox(width: width*0.025,),

                              Text("Add Address",style:_const.raleway_SemiBold_white(16, FontWeight.w600),),

                            ],
                          ),

                        ],
                      ),


                      SizedBox(height: height*0.05,),
                      isloading?SpinKitRotatingCircle(
                        color: Colors.black,
                        size: 50.0,
                      ):
                      InkWell(
                        onTap: ()async{
                          _submit();
                        },
                        child: Container(
                          height: height*0.055,
                          width: width*1,
                          margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
                          padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                          decoration: BoxDecoration(
                              color: blackbutton,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Text("Add new Card",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                        ),
                      ),
                      SizedBox(height: height*0.05,),

                    ],
                  ),
                ),
              ),
          ],
        ),

      ),
    );
  }
}
class CheckPayment{
  Payment ? payment;
  bool ? status;
  CheckPayment({required this.payment,required this.status});
}
class CheckAddress{
  Address ? address;
  bool ? status;
  CheckAddress({required this.address,required this.status});
}