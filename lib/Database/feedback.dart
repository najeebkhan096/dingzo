import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Feedback_Module{
  final String ? title;
  final double ? rating;
  final String ? docid;
  final String ? userid;
  final DateTime ? date;

  Feedback_Module({this.title,this.rating,this.docid,this.userid,this.date});

}
class FeedbackDatabase{
  Future post_feedback({Feedback_Module ? feedback})async{

    CollectionReference ? imgRef;
    Reference ? ref;

    imgRef = FirebaseFirestore.instance.collection('Feedback');
    await imgRef.add({
      'title':feedback!.title,
      'rating':feedback.rating,
      'userid':feedback.userid,
      'date':DateTime.now().toString()
    });
  }

}
FeedbackDatabase feedbackdatabase=FeedbackDatabase();
