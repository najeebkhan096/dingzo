import 'package:dingzo/Database/SociaMediaDatabase.dart';
import 'package:dingzo/Database/database.dart';
import 'package:dingzo/constants.dart';
import 'package:dingzo/hometesting.dart';
import 'package:dingzo/model/chat_reciver.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:dingzo/model/product.dart';
import 'package:dingzo/screens/chat/chat.dart';
import 'package:dingzo/screens/checkout.dart';
import 'package:dingzo/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dingzo/model/myuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation extends StatefulWidget {
  static const routename = "Conversation";

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();
  Constants _const=Constants();

Database _database=Database();

  @override
  void initState() {
    // TODO: implement initState
    bottom_index=3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: Colors.white,
      body: ListView(
        children: [


          SizedBox(
            height: height * 0.02,
          ),


          StreamBuilder(
              stream: FirebaseFirestore.instance.collection('chatRoom').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return SpinKitCircle(
                    color: Colors.black,
                  );

                if (!snapshot.hasData) return const Text('No Chat found');

                List<dynamic> newCategories = [];

                try{

                  List<QueryDocumentSnapshot?> mydocs = snapshot.data!.docs

                      .where((element) => (

                      (
                          ( element['users'] as List<dynamic>).contains(currentuser!.uid)

                      )

                  )

                  ).toList();

                  newCategories=mydocs;
                }catch(error){

                  print("No Chat found");
                }




                return
                  newCategories.isEmpty?

                  Column(
                    children: [
                      Container(
                          height: height*0.65,
                          width: width*1,

                          child: Center(child: Text("No Chat found",style: _const.manrope_regular78909C(15, FontWeight.w700),))),
                    ],
                  )

                      :

                  Column(
                    children: List.generate(newCategories.length, (index) =>

                        StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('Products').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> product_snaps) {
                              if (product_snaps.connectionState == ConnectionState.waiting)
                                return SpinKitCircle(
                                  color: Colors.black,
                                );
                              if (!product_snaps.hasData) return const Text('No Chat found');
                              QueryDocumentSnapshot ? desired_pro;
                              try{
                                List<QueryDocumentSnapshot?> product_docs = product_snaps.data!.docs
                                    .where((element) => (
                                    (
                                        element.id==newCategories[index]['product_id']

                                    )

                                )

                                ).toList();
                                QueryDocumentSnapshot ? desired_product= product_docs.first;
desired_pro=desired_product;
                              }catch(error){

                                print("No Chat Found");
                              }
return
  InkWell(
    onTap: () async {
      QueryDocumentSnapshot item =newCategories[index];
      String oppositeuser_id='';

      List<dynamic> users=item['users'];
      users.forEach((user_element) {
        if(user_element!=currentuser!.uid){
          oppositeuser_id=user_element;
        }
      });
     print("item is "+users.toString());

      MyUser ? opposite_user;
if(oppositeuser_id=="admin"){
opposite_user=MyUser(
  imageurl: "https://d2gg9evh47fn9z.cloudfront.net/1600px_COLOURBOX9896883.jpg",
  username: "admin",
  doc: "admin",
  uid: "admin"
);
}
else{
  opposite_user=await     database.fetch_seller_mini_detail(DesiredUserID: oppositeuser_id);

}


     List<dynamic> photos_dynamic=desired_pro!['photos'];

   List<String> desired_photos=[];


     photos_dynamic.forEach((photo_element) {
   desired_photos.add(photo_element['imageurl']);
     });
      Navigator.of(context).pushNamed(
          Chat_Screen.routename,
          arguments:  ChatReciever(
              chatid: item.id,
              user:   opposite_user,
              product:Product(id: desired_pro.id, price: desired_pro['price'],
                  title: desired_pro['title'], quantity: 1,
                photos: desired_photos,
                order_id: desired_pro['order_id']
              )
          )
      );
    },
    child: Container(

      margin: EdgeInsets.only(left: width*0.05,right: width*0.05,bottom: height*0.025),
      child:   Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (desired_pro!['photos']==null || desired_pro['photos'].isEmpty)?
          Container(
            width: width*0.3,
            height: height*0.17,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(child: Text("No Image")),
          ):

          Container(
            width: width*0.25,
            height: height*0.12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(desired_pro['photos'][0]['imageurl'])
                    ,fit: BoxFit.cover
                )
            ),
          ),

          Expanded(
            child: Container(

               margin: EdgeInsets.only(left: width*0.025),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(desired_pro['title']
                      .toString(),style: _const.poppin_Regualr_2C2C2C(13 ,FontWeight.w600)
                  ),



                  Container(

                    width: width*0.4,
                    child: Text(desired_pro['description']
                        .toString(),

                        style:  _const.poppin_Regualr_2C2C2C(13 ,FontWeight.w700,
                        ),
                    overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Text("08:12 PM",
          style: _const.manrope_regular_20C997(13 ,FontWeight.w600),
          )






        ],
      ),
    ),
  );

                            })
                    )
                  );

              }),



        ],
      ),

    );
  }
}
