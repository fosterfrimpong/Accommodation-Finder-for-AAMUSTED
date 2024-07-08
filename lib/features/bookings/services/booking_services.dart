import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unidwell_finder/features/bookings/data/booking_model.dart';

class BookingServices{
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _bookings = _firestore.collection('bookings');

  static Stream<List<BookingModel>>getAllBookings() {
    return _bookings.snapshots().map((event) => event.docs.map((e) => BookingModel.fromMap(e.data() as Map<String,dynamic>)).toList());

  }

  static updateBooking(String? id, Map<String, String> map) {}
}