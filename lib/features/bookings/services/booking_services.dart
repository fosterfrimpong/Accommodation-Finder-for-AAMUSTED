import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unidwell_finder/features/bookings/data/booking_model.dart';

class BookingServices{
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _bookings = _firestore.collection('bookings');

  static Stream<List<BookingModel>>getAllBookings() {
    return _bookings.snapshots().map((event) => event.docs.map((e) => BookingModel.fromMap(e.data() as Map<String,dynamic>)).toList());

  }

  static Future<bool> updateBooking(String id, Map<String, dynamic> map)async {
    try{
      await _bookings.doc(id).update(map);
      return true;
    }catch(e){
      return false;
    }
  }

  static String getId() {
    return _bookings.doc().id;
  }

  static Future<bool> addBooking(BookingModel booking) async{
    try{
      await _bookings.doc(booking.id).set(booking.toMap());
      return true;
    }catch(e){
      return false;
    }
  }
}