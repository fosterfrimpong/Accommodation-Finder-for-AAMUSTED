import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:unidwell_finder/features/hostels/data/hostels_model.dart';

class HostelServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _hostels = _firestore.collection('hostels');
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static String getId() {
    return _hostels.doc().id;
  }

  static Stream<List<HostelsModel>> getAllHostels() {
    return _hostels.snapshots().map((event) => event.docs
        .map((e) => HostelsModel.fromMap(e.data() as Map<String, dynamic>))
        .toList());
  }

  static Future<bool> addHostel(HostelsModel hostel) async {
    try {
      await _hostels.doc(hostel.id).set(hostel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateHostel(HostelsModel hostel) async {
    try {
      await _hostels.doc(hostel.id).update(hostel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteHostel(String id) async {
    try {
      await _hostels.doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<HostelsModel>> getHostels() async{
    try {
      var data = await _hostels.get();
      return data.docs.map((e) => HostelsModel.fromMap(e.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<HostelsModel?>getHostel({required String id})async {
    try {
      var data = await _hostels.doc(id).get();
      return HostelsModel.fromMap(data.data() as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
    
  }
}
