import 'package:cloud_firestore/cloud_firestore.dart';

class Crud {
  Future<void> addData(blogData) async {
    FirebaseFirestore.instance
        .collection('blogs')
        .add(blogData)
        .catchError((err) {
      print(err);
    });
  }
}
