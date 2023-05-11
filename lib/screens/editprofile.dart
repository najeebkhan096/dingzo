import 'dart:io';
import 'package:dingzo/screens/cart.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingzo/Database/auth.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as Path;

import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';


class EditProfile extends StatefulWidget {
  static const routename="EditProfile";

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Constants _const=Constants();
  List<File> _image = [];
  final picker = ImagePicker();
bool isloading=false;

  File? image_file1;
  String ? DpUrl;


  final GlobalKey<FormState> _formKey = GlobalKey();
  Future<void> _submit() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

setState(() {
  isloading=true;
});
                if(image_file1!=null){

                  await uploadFile().then((value) async{
                    if(DpUrl!.isNotEmpty){
                      await   auth.currentUser!.updatePhotoURL(DpUrl);
                      await auth.currentUser!.updateDisplayName(currentuser!.username);
                      await  database.updateuser(updateduser: currentuser).then((value) {
                        setState(() {
                          isloading=true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Data Updated"))
                        );
                      });
Navigator.of(context).pop();
                    }
                    else{
                      await    uploadFile().then((value) async{

                        if(DpUrl!.isNotEmpty){

                          await   auth.currentUser!.updatePhotoURL(DpUrl).then((value) async {

                            await auth.currentUser!.updateDisplayName(currentuser!.username).then((value) async {

                              await  database.updateuser(updateduser: currentuser).then((value) {
                                setState(() {
                                  isloading=true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Data Updated"))
                                );

                                Navigator.of(context).pop();
                              });

                            });

                          });



                        }
                      });
                    }
                  });



                }

            else{

                  await auth.currentUser!.updateDisplayName(currentuser!.username).then((value) async{
                    await  database.updateuser(updateduser: currentuser).then((value) {
                      setState(() {
                        isloading=true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Data Updated"))
                      );
                      Navigator.of(context).pop();
                    });
                  });


                }

  }

  Future getfile({int? choice}) async {
    if (choice == 0) {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.camera);
      setState(() {
        image_file1 = File(image!.path);
      });
    } else {
      final image =
      await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        image_file1 = File(image!.path);
      });
    }
  }
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;
  Future uploadFile() async {

    try {
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('${currentuser!.uid}/${Path.basename(image_file1!.path)}');
        await ref!.putFile(image_file1!).whenComplete(() async {
          await ref!.getDownloadURL().then((imageurl) {

        DpUrl=imageurl;
currentuser!.imageurl=imageurl;

          });
        });

    } catch (error) {

    }
  }

  void selectimage() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * 0.17,
              child: Column(
                children: [
                  ListTile(
                    onTap: () async{

                        await getfile(choice: 0,).then((value) {
                          Navigator.of(context).pop();
                        });

                    },
                    leading: Icon(
                      Icons.camera,
                      color: Colors.green,
                    ),
                    title: Text("Camera"),
                  ),
                  ListTile(
                    onTap: () async{

                        await getfile(choice: 1).then((value) {
                          Navigator.of(context).pop();
                        });

                    },
                    leading: Icon(
                      Icons.image,
                      color: Colors.green,
                    ),
                    title: Text("Gallery"),
                  )
                ],
              ),
            )));
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
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.8,
          leadingWidth: width*0.3
          ,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("My Profile",style: _const.manrope_regular263238(20, FontWeight.w800)),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();

          }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff3A4651),)),
          actions: [

          ],
        ),
        body: ListView(
          children: [

            SizedBox(height: height*0.025,),
            Container(
              margin: EdgeInsets.only(left: width*0.1),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  (image_file1!=null )?
                  Container(
                    height: 80,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.values[0],
                        image: FileImage(File(image_file1!.path))
                      )
                    ),
                  ):
                  (currentuser!.imageurl==null || currentuser!.imageurl!.isEmpty )?
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("images/radiant.png"),
                  ):
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(currentuser!.imageurl.toString()),
                  ),

                  SizedBox(width: width*0.05,),
                  InkWell(
                      onTap: ()  {
                         selectimage();
                      },
                      child: Text("Edit Profile Photo",style:_const.raleway_535F5B(20, FontWeight.w600))),
                ],
              ),
            ),
            SizedBox(height: height*0.025,),


  Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height*0.05,),


        Center(child: Text("Change Username",style:_const.raleway_535F5B(20, FontWeight.w600))),
        SizedBox(height: height*0.025,),


        Container(
          margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

          height: height*0.07,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: rgbcolor,
              borderRadius: BorderRadius.circular(10)
          ),
          child: TextFormField(
            onSaved: (val){
              currentuser!.username=val;
            },
            onChanged: (val){

                currentuser!.username=val;

            },
            textAlign: TextAlign.center,
            initialValue: currentuser!.username,
            decoration: InputDecoration(
                border: InputBorder.none,
              hintText: 'Required',
              hintStyle: _const.raleway_rgb_textfield(13, FontWeight.w600),),

            style: _const.raleway_rgb_textfield(13, FontWeight.w600),),
        ),
        SizedBox(height: height*0.025,),




        Center(child: Text("Change Profile Description",style:_const.raleway_535F5B(20, FontWeight.w600))),
        SizedBox(height: height*0.025,),


        Container(
          margin: EdgeInsets.only(left: width*0.1,right: width*0.1),
          height: height*0.15,
          width: width*1,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: rgbcolor,
              borderRadius: BorderRadius.circular(10)
          ),
          padding: EdgeInsets.only(left: width*0.025,right: width*0.025),
          child: TextFormField(
            maxLines: 5,
            onSaved: (val){
              currentuser!.bio=val;
            },
            onChanged: (val){

              currentuser!.bio=val;

            },
            textAlign: TextAlign.center,
            keyboardType: TextInputType.multiline,
            initialValue: currentuser!.bio.toString(),
            decoration: InputDecoration(
                border: InputBorder.none,
              hintText: "[Optional]",
              hintStyle: _const.raleway_rgb_textfield(13, FontWeight.w600),),
            style: _const.raleway_rgb_textfield(17, FontWeight.w600),),
        ),
        SizedBox(height: height*0.025,),

      ],
    ),
  ),




            SizedBox(height: height*0.025,),

            isloading?SpinKitRotatingCircle(
              color: Colors.black,
              size: 50.0,
            ):
            InkWell(
              onTap: (){
              _submit();


            },
              child: Container(
                height: height*0.055,
                width: width*1,
                margin: EdgeInsets.only(left: width*0.1,right: width*0.1),

               decoration: BoxDecoration(
                    color: blackbutton,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text("Update",style:_const.raleway_SemiBold_white(16, FontWeight.w600),)),
              ),
            ),

            SizedBox(height: height*0.025,),
          ],
        ),

      ),
    );
  }
}
