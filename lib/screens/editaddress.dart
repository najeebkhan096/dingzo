
import 'dart:convert';

import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/model/myclipper.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class EditAddress extends StatefulWidget {
  static const routename="EditAddress";

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  Constants _const = Constants();
    bool isloading=false;
bool edit=false;
bool add_new_address=false;
bool verified=false;

Future<String?>  access_token()async{
  String ? _token;
  var headers = {
    'Authorization': 'Basic R3NmSHFVeFJNY3M1ZFBBYmZtSTh2ZzBCUEc4MWhyMk46eFpQVnIwYTBXMFpoSVpKaA==',
    'Content-Type': 'application/x-www-form-urlencoded'
  };



final request=await  http.post(Uri.parse('https://shipping-api-sandbox.pitneybowes.com/oauth/token'),
 headers: headers,
body: {
  'grant_type': 'client_credentials'
}
);
final  response =jsonDecode(request.body);
  if (request.statusCode == 200) {
_token=response['access_token'];

  }
  else {

  }
return _token;
}

  Future<void>  verify_address(String token,)async{
    var headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json',
      'X-PB-UnifiedErrorStructure': 'true'
    };


    final request=await  http.post(Uri.parse('https://shipping-api-sandbox.pitneybowes.com/shippingservices/v1/addresses/verify'),
        headers: headers,
        body:
        json.encode({
        "addressLines": [
        currentuser!.home_address![selected_index].address1,
        "",
        ""
        ],
        "cityTown":  currentuser!.home_address![selected_index].city,
         "stateProvince":  currentuser!.home_address![selected_index].state,
        "postalCode":  currentuser!.home_address![selected_index].zipcode,
         "countryCode":  "US",
        "name":  currentuser!.home_address![selected_index].firstname
        })

    );
    final  response =jsonDecode(request.body);
    if (request.statusCode == 200) {
print("verified "+request.body.toString());
await  database.updateUserHomeAddress(updateduser: currentuser).then((value) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Edited Successfully"),
    backgroundColor: Colors.green,
  ));
  Navigator.of(context).pop();
});

    }
    else {
setState(() {
  isloading=false;
});
      print("failed  "+request.body.toString());
_showErrorDialog("Address is Invalid");

    }

  }
  Future<void>  add_verify_address(String token,)async{
    var headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'application/json',
      'X-PB-UnifiedErrorStructure': 'true'
    };



    final request=await  http.post(Uri.parse('https://shipping-api-sandbox.pitneybowes.com/shippingservices/v1/addresses/verify'),
        headers: headers,
        body:
        json.encode({
          "addressLines": [
            newaddress!.address1,
            "",
            ""
          ],
          "cityTown":  newaddress!.city,
          "stateProvince":  newaddress!.state,
          "postalCode":  newaddress!.zipcode,
          "countryCode":  "US",
          "name":  newaddress!.firstname
        })

    );
    final  response =jsonDecode(request.body);
    if (request.statusCode == 200) {
      print("verified "+request.body.toString());
      currentuser!.home_address!.add(newaddress!);
      await  database.updateUserHomeAddress(updateduser: currentuser).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Added Successfully"),
          backgroundColor: Colors.green,
        ));
        Navigator.of(context).pushNamedAndRemoveUntil(HomeTesting.routename, (route) => false);
      });

    }
    else {
      setState(() {
        isloading=false;
      });
      print("failed  "+request.body.toString());
      _showErrorDialog("Address is Invalid");

    }

  }

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
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _submit() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      isloading=true;
    });


      try {

      String ? token=await  access_token();
      await verify_address(token!);
      } catch(error){
        setState(() {
          isloading=false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Editing failed. Please try again"),
          backgroundColor: Colors.red,
        ));

      }

    }

  Future<void> _addsubmit() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      isloading=true;
    });


    try {

      String ? token=await  access_token();
      await add_verify_address(token!);
    } catch(error){
      setState(() {
        isloading=false;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Adding failed. Please try again"),
        backgroundColor: Colors.red,
      ));

    }

  }
int selected_index=0;
Address ? newaddress=Address(
  address1: '',
  address2: '',
  city: '',
  firstname: '',
  lastlast: '',
  state: '',
  vocation: false,
  zipcode: '',
  ExpiyDate: ''
);


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.8,
          leadingWidth: width*0.3
          ,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("My Address",style: _const.manrope_regular263238(20, FontWeight.w800)),
          actions: [


          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [

            SizedBox(
              height: height * 0.05,
            ),
            Container(
                margin: EdgeInsets.only(left: width * 0.1),
                child: Text("Home Address",
                    style: _const.raleway_535F5B(20, FontWeight.w600))),
            SizedBox(
              height: height * 0.025,
            ),
            Column(
              children: List.generate(currentuser!.home_address!.length, (index) =>   Container(
                margin: EdgeInsets.only(left: width * 0.02),
                child: Row(

                  children: [

                    Container(
                      margin: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: width * 0.5,
                              child: Text(
                                  currentuser!.home_address![index].firstname.toString()+" "+  currentuser!.home_address![index].lastlast.toString()+" "+  currentuser!.home_address![index].address1.toString()+" "+  currentuser!.home_address![index].address2.toString() +" "+  currentuser!.home_address![index].city.toString() +" "+  currentuser!.home_address![index].state.toString() +" "+  currentuser!.home_address![index].zipcode.toString(),

                                  style: _const.raleway_535F5B(
                                      15, FontWeight.w600))),
                          InkWell(
                            onTap: (){
                              setState(() {
                                edit=true;
                     selected_index=index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: rgbcolor,
                                  borderRadius: BorderRadius.circular(15)),
                              padding: EdgeInsets.only(
                                  left: width * 0.04,
                                  right: width * 0.04,
                                  bottom: height * 0.01,
                                  top: height * 0.01),
                              child: Text("Edit",
                                  style: _const.raleway_rgb_textfield(17, FontWeight.w700)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),),
            ),

            SizedBox(height: height*0.025,),
            Divider(),
            SizedBox(height: height*0.025,),
            InkWell(
              onTap: (){

setState(() {
  add_new_address=true;
});

              },
              child: Container(
                height: height*0.055,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                decoration: BoxDecoration(
                    color: blackbutton,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Add new Address",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
              ),
            ),
            SizedBox(height: height*0.025,),
            if(edit)
            Form(
              key: _formKey,
              child: Container(
                width: width * 1,
                color: rgbcolor,
                padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: Column(
                  children: [


                    SizedBox(height: height*0.025,),
                    Text(
                      "Edit Address",
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
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child:TextFormField(
                            onSaved: (val){
                              currentuser!.home_address![selected_index].firstname=val;
                            },
                            onChanged: (val){

                             currentuser!.home_address![selected_index].firstname=val;

                            },
                            textAlign: TextAlign.center,
                            initialValue:currentuser!.home_address![selected_index].firstname,
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
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            onSaved: (val){
                             currentuser!.home_address![selected_index].lastlast=val;
                            },
                            onChanged: (val){

                             currentuser!.home_address![selected_index].lastlast=val;

                            },
                            textAlign: TextAlign.center,
                            initialValue:currentuser!.home_address![selected_index].lastlast,
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
                          child: Text("Address 1:",
                              style: _const.raleway_535F5B(
                                  19, FontWeight.w700)),
                        ),
                        Container(
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            onSaved: (val){
                             currentuser!.home_address![selected_index].address1=val;
                            },
                            onChanged: (val){

                             currentuser!.home_address![selected_index].address1=val;

                            },
                            textAlign: TextAlign.center,
                            initialValue:currentuser!.home_address![selected_index].address1,
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
                          child: Text("Address 2:",
                              style: _const.raleway_535F5B(
                                  19, FontWeight.w700)),
                        ),
                        Container(
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            onSaved: (val){
                             currentuser!.home_address![selected_index].address2=val;
                            },
                            onChanged: (val){

                             currentuser!.home_address![selected_index].address2=val;

                            },
                            textAlign: TextAlign.center,
                            initialValue:currentuser!.home_address![selected_index].address2,
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
                          child: Text("City:",
                              style: _const.raleway_535F5B(
                                  19, FontWeight.w700)),
                        ),
                        Container(
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            onSaved: (val){
                             currentuser!.home_address![selected_index].city=val;
                            },
                            onChanged: (val){

                             currentuser!.home_address![selected_index].city=val;

                            },
                            textAlign: TextAlign.center,
                            initialValue:currentuser!.home_address![selected_index].city,
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
                          child: Text("State :",
                              style: _const.raleway_535F5B(
                                  19, FontWeight.w700)),
                        ),
                        Container(
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            onSaved: (val){
                             currentuser!.home_address![selected_index].state=val;
                            },
                            onChanged: (val){

                             currentuser!.home_address![selected_index].state=val;

                            },
                            textAlign: TextAlign.center,
                            initialValue:currentuser!.home_address![selected_index].state,
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
                          child: Text("Zip Code :",
                              style: _const.raleway_535F5B(
                                  19, FontWeight.w700)),
                        ),
                        Container(
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: TextFormField(
                            onSaved: (val){
                             currentuser!.home_address![selected_index].zipcode=val;
                            },
                            onChanged: (val){

                             currentuser!.home_address![selected_index].zipcode=val;

                            },
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            initialValue:currentuser!.home_address![selected_index].zipcode,
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                            style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                          height: height * 0.055,
                        )
                      ],
                    ),

                    SizedBox(height: height*0.05,),
                    isloading?SpinKitRotatingCircle(
                      color: mycolor,
                      size: 50.0,
                    ):
                    verified?InkWell(

                      onTap: () async {


                         _submit();

                      },
                      child: Container(
                        height: height*0.055,
                        width: width*1,
                        margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                        padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                        decoration: BoxDecoration(
                            color: Color(0xffEFB546),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(child: Text("Edit Address",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                      ),
                    ):
                    InkWell(

                      onTap: () async {
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
                        child: Center(child: Text("Submit Address",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                      ),
                    ),
                    SizedBox(height: height*0.05,),

                  ],
                ),
              ),
            ),

            if(add_new_address)
              Form(
                key: _formKey,
                child: Container(
                  width: width * 1,
                  color: rgbcolor,
                  padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: Column(
                    children: [


                      SizedBox(height: height*0.025,),
                      Text(
                        "Add new Address",
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
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child:TextFormField(
                              onSaved: (val){
                              newaddress!.firstname=val;
                              },
                              onFieldSubmitted: (val){

                                newaddress!.firstname=val;

                              },
                              textAlign: TextAlign.center,
                              initialValue: newaddress!.firstname,
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
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: TextFormField(
                              onSaved: (val){
                                newaddress!.lastlast=val;
                              },
                              onFieldSubmitted: (val){

                                newaddress!.lastlast=val;

                              },
                              textAlign: TextAlign.center,
                              initialValue: newaddress!.lastlast,
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
                            child: Text("Address 1:",
                                style: _const.raleway_535F5B(
                                    19, FontWeight.w700)),
                          ),
                          Container(
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: TextFormField(
                              onSaved: (val){
                                newaddress!.address1=val;
                              },
                              onFieldSubmitted: (val){

                                newaddress!.address1=val;

                              },
                              textAlign: TextAlign.center,
                              initialValue: newaddress!.address1,
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
                            child: Text("Address 2:",
                                style: _const.raleway_535F5B(
                                    19, FontWeight.w700)),
                          ),
                          Container(
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: TextFormField(
                              onSaved: (val){
                                newaddress!.address2=val;
                              },
                              onFieldSubmitted: (val){

                                newaddress!.address2=val;

                              },
                              textAlign: TextAlign.center,
                              initialValue: newaddress!.address2,
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
                            child: Text("City:",
                                style: _const.raleway_535F5B(
                                    19, FontWeight.w700)),
                          ),
                          Container(
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: TextFormField(
                              onSaved: (val){
                                newaddress!.city=val;
                              },
                              onFieldSubmitted: (val){

                                newaddress!.city=val;

                              },
                              textAlign: TextAlign.center,
                              initialValue: newaddress!.city,
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
                            child: Text("State :",
                                style: _const.raleway_535F5B(
                                    19, FontWeight.w700)),
                          ),
                          Container(
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: TextFormField(
                              onSaved: (val){
                                newaddress!.state=val;
                              },
                              onFieldSubmitted: (val){

                                newaddress!.state=val;

                              },
                              textAlign: TextAlign.center,
                              initialValue: newaddress!.state,
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
                            child: Text("Zip Code :",
                                style: _const.raleway_535F5B(
                                    19, FontWeight.w700)),
                          ),
                          Container(
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: TextFormField(
                              onSaved: (val){
                                newaddress!.zipcode=val;
                              },
                              onFieldSubmitted: (val){

                                newaddress!.zipcode=val;

                              },
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              initialValue: newaddress!.zipcode,
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                              style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
                            height: height * 0.055,
                          )
                        ],
                      ),

                      SizedBox(height: height*0.05,),
                      isloading?SpinKitRotatingCircle(
                        color: mycolor,
                        size: 50.0,
                      ):
                      verified?InkWell(

                        onTap: () async {


                          _submit();

                        },
                        child: Container(
                          height: height*0.055,
                          width: width*1,
                          margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

                          padding: EdgeInsets.only(left: width*0.02,right: width*0.02),
                          decoration: BoxDecoration(
                              color: Color(0xffEFB546),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(child: Text("Edit Address",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
                        ),
                      ):
                      InkWell(

                        onTap: () async {
                          _addsubmit();
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
                          child: Center(child: Text("Submit new Address",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
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