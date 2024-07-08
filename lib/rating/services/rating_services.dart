import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unidwell_finder/rating/data/rating.dart';

class RatingServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static String getId() {
    return _firestore.collection('ratings').doc().id;
  }

  static Future<void> addRating(RatingModel rating) async {
    await _firestore.collection('ratings').doc(rating.id).set(rating.toMap());
  }

  static Future<List<RatingModel>> getRatings() async {
    final snapshot = await _firestore.collection('ratings').get();
    return snapshot.docs.map((doc) => RatingModel.fromMap(doc.data())).toList();
  }

  static Future<List<RatingModel>> getRoomRating(String id) {
    return _firestore
        .collection('ratings')
        .where('roomId', isEqualTo: id)
        .get()
        .then((value) => value.docs.map((e) => RatingModel.fromMap(e.data())).toList());
  }
}
