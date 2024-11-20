import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kyn/models/user_model.dart';

Stream<UserModel> getUserData(String uid) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
}
