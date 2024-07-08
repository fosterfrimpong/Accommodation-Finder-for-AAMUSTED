import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unidwell_finder/features/institutions/data/institutions_model.dart';

class InstitutionServices{
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

static String getInstitutionId(){
    return _firestore.collection('institutions').doc().id;
  }
  static Stream<List<InstitutionsModel>> getInstitutions(){
    return _firestore.collection('institutions').snapshots().map((snapshot) => snapshot.docs.map((doc) => InstitutionsModel.fromMap(doc.data())).toList());
  }

  static Future<bool> addInstitution(InstitutionsModel institution) async{
    try {
      await _firestore.collection('institutions').doc(institution.id).set(institution.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateInstitution(InstitutionsModel institution) async{
    try {
      await _firestore.collection('institutions').doc(institution.id).update(institution.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool>deleteInstitution(InstitutionsModel item)async {
    try {
      await _firestore.collection('institutions').doc(item.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}