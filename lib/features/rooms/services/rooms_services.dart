
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:unidwell_finder/features/rooms/data/rooms_model.dart';

class RoomsServices{
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _rooms = _firestore.collection('rooms');
  static final FirebaseStorage _storage = FirebaseStorage.instance;

static String getId (){
  return _firestore.collection('rooms').doc().id;
}
  
  static Stream<List<RoomsModel>>getAllRooms() {
    return _rooms.snapshots().map((event) => event.docs.map((e) => RoomsModel.fromMap(e.data() as Map<String,dynamic>)).toList());
  }

  static Future<bool>saveRoom(RoomsModel value) async{
    try {
      await _rooms.doc(value.id).set(value.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future <List<RoomsModel>>getRooms() async{
    try {
      var data = await _rooms.get();
      return data.docs.map((e) => RoomsModel.fromMap(e.data() as Map<String,dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }
}