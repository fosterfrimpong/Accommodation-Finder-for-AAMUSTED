import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:unidwell_finder/core/constatnts/paystack_keys.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/features/auth/providers/user_provider.dart';
import 'package:unidwell_finder/features/bookings/data/booking_model.dart';
import 'package:unidwell_finder/features/bookings/services/booking_services.dart';
import 'package:unidwell_finder/features/hostels/services/hostel_services.dart';

import 'package:unidwell_finder/features/rooms/data/rooms_model.dart';
import 'package:unidwell_finder/features/rooms/services/rooms_services.dart';

import '../../../core/functions/payment/paystack_integration.dart';

class BookingItem {
  RoomsModel? room;
  int spaces;
  double totalCost;
  BookingItem({
    required this.room,
    this.spaces = 0,
    required this.totalCost,
  });

  BookingItem copyWith({
    ValueGetter<RoomsModel?>? room,
    int? spaces,
    double? totalCost,
  }) {
    return BookingItem(
      room: room != null ? room() : this.room,
      spaces: spaces ?? this.spaces,
      totalCost: totalCost ?? this.totalCost,
    );
  }
}

final bookingProvider = StateNotifierProvider<BookingProvider, BookingItem?>(
    (ref) => BookingProvider());

class BookingProvider extends StateNotifier<BookingItem?> {
  BookingProvider() : super(null);

  void setRoom(RoomsModel room) {
    state = BookingItem(room: room, spaces: 1, totalCost: room.price);
  }

  void increaseSpace() {
    var space = state!.spaces + 1;
    var totalCost = (state!.room!.price + state!.room!.additionalCost) * space;
    state = state!.copyWith(spaces: space, totalCost: totalCost);
  }

  void decreaseSpace() {
    var space = state!.spaces - 1;
    var totalCost = (state!.room!.price + state!.room!.additionalCost) * space;
    state = state!.copyWith(spaces: space, totalCost: totalCost);
  }

  void removeRoom() {
    state = null;
  }

  void book(WidgetRef ref, BuildContext context) async {
    CustomDialogs.dismiss();
    CustomDialogs.loading(
      message: 'Booking room...',
    );
    var user = ref.read(userProvider);
    var reference = 'unidwell-${DateTime.now().millisecondsSinceEpoch}';
    print('Amount: ${state!.totalCost}');
    if (kIsWeb) {
      await PaystackPopup.openPaystackPopup(
        email: user.email,
        amount: int.parse(state!.totalCost.toStringAsFixed(0)),
        ref: reference,
        onClosed: () {
          CustomDialogs.dismiss();
          CustomDialogs.showDialog(
              message: 'Payment cancelled', type: DialogType.error);
        },
        onSuccess: () async {
          //create booking here
          var hostelId = state!.room!.hostelId;
          print('HostelId: $hostelId');
          var hostel = await HostelServices.getHostel(id: hostelId);
          if (hostel == null) {
            CustomDialogs.dismiss();
            CustomDialogs.showDialog(
                message: 'Hostel not found', type: DialogType.error);
            return;
          }
          var booking = BookingModel(
            id: BookingServices.getId(),
            roomId: state!.room!.id,
            managerEmail: state!.room!.managerEmail,
            managerId: state!.room!.managerId,
            managerName: state!.room!.managerName,
            managerPhone: state!.room!.managerPhone,
            studentId: user.id,
            studentEmail: user.email,
            studentName: user.name,
            studentPhone: user.phone,
            startDate: DateFormat('EEE,MMM dd,yyyy').format(DateTime.now()),
            endDate: DateFormat('EEE,MMM dd,yyyy')
                .format(DateTime.now().add(const Duration(days: 365))),
            totalCost: state!.totalCost,
            additionalCost: state!.room!.additionalCost,
            status: 'pending',
            partyIds: [state!.room!.managerId, user.id],
            roomCost: state!.room!.price,
            roomDescription: state!.room!.description,
            roomImages: state!.room!.images,
            roomName: state!.room!.title,
            paymentDate: DateTime.now().millisecondsSinceEpoch,
            paymentStatus: 'paid',
            paymentId: reference,
            paymentMethod: 'paystack',
            hostelAddress: hostel.location,
            hostelId: hostel.id,
            hostelName: hostel.name,
            hostelLatitude: hostel.lat,
            hostelLongitude: hostel.lng,
            createdAt: DateTime.now().millisecondsSinceEpoch,
          );
          var responds = await BookingServices.addBooking(booking);
          //update room available slot
          var room = state!.room!.copyWith(
              availableSpace: state!.room!.availableSpace - state!.spaces);
          await RoomsServices.updateRoom(room: room);
          CustomDialogs.dismiss();
          if (responds) {
            CustomDialogs.showDialog(
                message: 'Room booked successfully', type: DialogType.success);
            state = state!.copyWith(room: null, spaces: 0, totalCost: 0.0);
          } else {
            CustomDialogs.showDialog(
                message: 'Failed to book room', type: DialogType.error);
          }
        },
      );
    } else {
      final uniqueTransRef = PayWithPayStack().generateUuidV4();

      PayWithPayStack().now(
          context: context,
          secretKey: testSecretKey,
          customerEmail: user.email,
          reference: uniqueTransRef,
          callbackUrl: "setup in your paystack dashboard",
          currency: "GHS",
          paymentChannel: ["mobile_money", "card"],
          amount: state!.totalCost,
          transactionCompleted: () {
            print("Transaction Successful");
          },
          transactionNotCompleted: () {
            print("Transaction Not Successful!");
          });
    }
  }
}
