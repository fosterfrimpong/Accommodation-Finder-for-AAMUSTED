import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/core/functions/sms_api.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/features/auth/data/user_model.dart';
import 'package:unidwell_finder/features/auth/providers/user_provider.dart';
import 'package:unidwell_finder/features/auth/services/registration_services.dart';
import 'package:unidwell_finder/features/bookings/data/booking_model.dart';
import 'package:unidwell_finder/features/hostels/data/hostels_model.dart';
import 'package:unidwell_finder/features/hostels/services/hostel_services.dart';
import 'package:unidwell_finder/features/rooms/data/rooms_model.dart';
import 'package:unidwell_finder/features/rooms/services/rooms_services.dart';

import '../../bookings/services/booking_services.dart';

final adminManagersStream = StreamProvider<List<UserModel>>((ref) async* {
  var data = RegistrationServices.getmanagers();
  await for (var item in data) {
    ref.read(managersFilterProvider.notifier).setItems(item);
    yield item;
  }
});

class ManagerFilter {
  List<UserModel> items;
  List<UserModel> filteredList;
  ManagerFilter({
    this.items = const [],
    this.filteredList = const [],
  });

  ManagerFilter copyWith({
    List<UserModel>? items,
    List<UserModel>? filteredList,
  }) {
    return ManagerFilter(
      items: items ?? this.items,
      filteredList: filteredList ?? this.filteredList,
    );
  }
}

final managersFilterProvider =
    StateNotifierProvider<ManagerFilterProvider, ManagerFilter>((ref) {
  return ManagerFilterProvider();
});

class ManagerFilterProvider extends StateNotifier<ManagerFilter> {
  ManagerFilterProvider() : super(ManagerFilter(items: [], filteredList: []));

  void setItems(List<UserModel> items) async {
    state = state.copyWith(items: items, filteredList: items);
  }

  void filterManagers(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filteredList: state.items);
    } else {
      var filtered = state.items.where((element) {
        return element.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      state = state.copyWith(filteredList: filtered);
    }
  }

  void updateManager(UserModel manager, String status) async {
    CustomDialogs.dismiss();
    CustomDialogs.loading(
        message: status == 'banned'
            ? 'Blocking Manager...'
            : 'Unblocking Manager...');
    manager = manager.copyWith(status: status);
    var res = await RegistrationServices.updateUser(manager);
    if (res) {
      //send notification to doctor
      var phone = manager.password;
      var message = status == 'banned'
          ? 'Your Account has been Blocked.You can no longer access the Accommodation Finder. Contact Admin for more information'
          : 'Your Account has been Unblocked. You can now access the Accommodation Finder platform';
      await SmsApi().sendMessage(phone!, message);
      state = state.copyWith(
          filteredList: state.filteredList
              .map((e) => e.id == manager.id ? manager : e)
              .toList(),
          items: state.items
              .map((e) => e.id == manager.id ? manager : e)
              .toList());
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: status == 'banned'
              ? 'Manager Banned Successfully'
              : 'Manager Unbanned Successfully',
          type: DialogType.success);
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: status == 'banned'
              ? 'Failed to Band Manager'
              : 'Failed to Unban Manager',
          type: DialogType.error);
    }
  }

  void changeStatus(UserModel user, String s) async {
    CustomDialogs.dismiss();
    CustomDialogs.loading(message: 'Updating Manager Status');
    user = user.copyWith(status: s);
    var data = await RegistrationServices.updateUser(user);
    CustomDialogs.dismiss();
    if (data) {
      state = state.copyWith(
          items: state.items
              .map((e) => e.id == user.id ? user : e)
              .toList(),
          filteredList: state.filteredList
              .map((e) => e.id == user.id ? user : e)
              .toList());
      CustomDialogs.toast(
          message: 'Manager Status Updated Successfully',
          type: DialogType.success);
    } else {
      CustomDialogs.toast(
          message: 'Failed to Update Manager Status',
          type: DialogType.error);
    }
  }
}

final adminStudentsStreamProvider =
    StreamProvider<List<UserModel>>((ref) async* {
  var data = RegistrationServices.getStudents();
  await for (var item in data) {
    ref.read(studentsFilterProvider.notifier).setItems(item);
    yield item;
  }
});

class StudentsFilter {
  List<UserModel> items;
  List<UserModel> filteredList;
  StudentsFilter({
    this.items = const [],
    this.filteredList = const [],
  });

  StudentsFilter copyWith({
    List<UserModel>? items,
    List<UserModel>? filteredList,
  }) {
    return StudentsFilter(
      items: items ?? this.items,
      filteredList: filteredList ?? this.filteredList,
    );
  }
}

final studentsFilterProvider =
    StateNotifierProvider<StudentsFilterProvider, StudentsFilter>((ref) {
  return StudentsFilterProvider();
});

class StudentsFilterProvider extends StateNotifier<StudentsFilter> {
  StudentsFilterProvider() : super(StudentsFilter(items: [], filteredList: []));

  void setItems(List<UserModel> items) async {
    state = state.copyWith(items: items, filteredList: items);
  }

  void filterStudents(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filteredList: state.items);
    } else {
      var filtered = state.items.where((element) {
        return element.name.toLowerCase().contains(query.toLowerCase()) ||
            element.school!.toLowerCase().contains(query.toLowerCase());
      }).toList();

      state = state.copyWith(filteredList: filtered);
    }
  }

  void updatePatient(UserModel student, String status) async {
    CustomDialogs.dismiss();
    CustomDialogs.loading(
        message: status == 'banned'
            ? 'Blocking Student...'
            : 'Unblocking Student...');
    student = student.copyWith(status: status);
    var res = await RegistrationServices.updateUser(student);
    if (res) {
      state = state.copyWith(
          filteredList: state.filteredList
              .map((e) => e.id == student.id ? student : e)
              .toList(),
          items: state.items
              .map((e) => e.id == student.id ? student : e)
              .toList());
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: status == 'banned'
              ? 'Student Banned Successfully'
              : 'Student Unbanned Successfully',
          type: DialogType.success);
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: status == 'banned'
              ? 'Failed to Band Student'
              : 'Failed to Unban Student',
          type: DialogType.error);
    }
  }

  void changeStatus(UserModel student, String s)async {
    CustomDialogs.dismiss();
    CustomDialogs.loading(message: 'Updating Student Status');
    student = student.copyWith(status: s);
    var data = await RegistrationServices.updateUser(student);
    CustomDialogs.dismiss();
    if (data) {
      state = state.copyWith(
          items: state.items
              .map((e) => e.id == student.id ? student : e)
              .toList(),
          filteredList: state.filteredList
              .map((e) => e.id == student.id ? student : e)
              .toList());
      CustomDialogs.toast(
          message: 'Student Status Updated Successfully',
          type: DialogType.success);
    } else {
      CustomDialogs.toast(
          message: 'Failed to Update Student Status',
          type: DialogType.error);
    }
  }
}

final adminBookingsStreamProvider =
    StreamProvider<List<BookingModel>>((ref) async* {
  var data = BookingServices.getAllBookings();
  await for (var item in data) {
    ref.read(allBookingsProvider.notifier).state = item;
    yield item;
  }
});

class BookingsFilter {
  List<BookingModel> items;
  List<BookingModel> filter;

  BookingsFilter({
    this.items = const [],
    this.filter = const [],
  });

  BookingsFilter copyWith({
    List<BookingModel>? items,
    List<BookingModel>? filter,
  }) {
    return BookingsFilter(
      items: items ?? this.items,
      filter: filter ?? this.filter,
    );
  }
}

final allBookingsProvider = StateProvider<List<BookingModel>>((ref) {
  return [];
});

final bookingFilterProvider = StateNotifierProvider.family<
    BookingsFilterProvider, BookingsFilter, String?>((ref, id) {
  var data = ref.watch(allBookingsProvider);
  var user = ref.watch(userProvider);
  if (id != null && id.isNotEmpty) {
    var items = data
        .where((element) => element.studentId == id || element.managerId == id)
        .toList();
    return BookingsFilterProvider()..setItems(items,user);
  }
  return BookingsFilterProvider()..setItems(data,user);
});

class BookingsFilterProvider extends StateNotifier<BookingsFilter> {
  BookingsFilterProvider() : super(BookingsFilter(items: []));

  void setItems(List<BookingModel> items, UserModel user) async {
    if (user.role == 'manager') {
      items = items.where((element) => element.managerId == user.id).toList();
    }
    state = state.copyWith(items: items, filter: items);
  }

  void filterBookings(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filter: state.items);
    } else {
      var filtered = state.items.where((element) {
        return element.hostelName!
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            element.managerName!.toLowerCase().contains(query.toLowerCase()) ||
            element.studentName!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      state = state.copyWith(filter: filtered);
    }
  }

  void cancelBooking(BookingModel booking, UserModel user) async {
    CustomDialogs.dismiss();
    CustomDialogs.loading(message: 'Cancelling Booking');
    var data = await BookingServices.updateBooking(
        booking.id, {'status': 'cancelled'});

    if (data) {
      //send notification to patient
      var phone = booking.studentId == user.id
          ? booking.managerPhone
          : booking.studentPhone;
      if (phone != null) {
        var message =
            'Your Room booking at ${booking.hostelName} has been Cancelled';
        await SmsApi().sendMessage(phone, message);
      }
      state = state.copyWith(
          items: state.items
              .map((e) => e.id == booking.id
                  ? booking.copyWith(status: () => 'cancelled')
                  : e)
              .toList());
      CustomDialogs.dismiss();
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'Booking Cancelled', type: DialogType.success);
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'Failed to Cancel Booking', type: DialogType.error);
    }
  }

  void acceptBooking(BookingModel booking, UserModel user) async {
    CustomDialogs.dismiss();
    CustomDialogs.loading(message: 'Accepting Booking');
    var data =
        await BookingServices.updateBooking(booking.id, {'status': 'accepted'});

    if (data) {
      var message =
          'Your Room booking at ${booking.hostelName} has been Accepted';
      await SmsApi().sendMessage(booking.studentPhone!, message);
      state = state.copyWith(
          items: state.items
              .map((e) => e.id == booking.id
                  ? booking.copyWith(status: () => 'accepted')
                  : e)
              .toList());
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'Booking Accepted', type: DialogType.success);
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'Failed to Accept Booking', type: DialogType.error);
    }
  }
}

final adminHostelsStreamProvider =
    StreamProvider<List<HostelsModel>>((ref) async* {
  var data = HostelServices.getAllHostels();
  var user = ref.read(userProvider);
  await for (var item in data) {
    ref.read(hostelsFilterProvider.notifier).setItems(item, user);
    yield item;
  }
});

class HostelsFilter {
  List<HostelsModel> items;
  List<HostelsModel> filteredList;
  HostelsFilter({
    this.items = const [],
    this.filteredList = const [],
  });

  HostelsFilter copyWith({
    List<HostelsModel>? items,
    List<HostelsModel>? filteredList,
  }) {
    return HostelsFilter(
      items: items ?? this.items,
      filteredList: filteredList ?? this.filteredList,
    );
  }
}

final hostelsFilterProvider =
    StateNotifierProvider<HostelsProvider, HostelsFilter>((ref) {
  return HostelsProvider();
});

class HostelsProvider extends StateNotifier<HostelsFilter> {
  HostelsProvider() : super(HostelsFilter(items: [], filteredList: []));
  void setItems(List<HostelsModel> items, UserModel user) {
    if (user.role == 'manager') {
      items = items.where((element) => element.managerId == user.id).toList();
    }
    state = state.copyWith(items: items, filteredList: items);
  }

  void filterHostels(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filteredList: state.items);
    } else {
      var filtered = state.items.where((element) {
        return element.name.toLowerCase().contains(query.toLowerCase()) ||
            element.location.toLowerCase().contains(query.toLowerCase());
      }).toList();
      state = state.copyWith(filteredList: filtered);
    }
  }

  void changeHostelState(HostelsModel hostelList, String s)async {
    CustomDialogs.dismiss();
    CustomDialogs.loading(message: 'Updating Hostel Status');
    hostelList = hostelList.copyWith(status: s);
    var data = await HostelServices.updateHostel(hostelList);
    CustomDialogs.dismiss();
    if (data) {
      state = state.copyWith(
          items: state.items
              .map((e) => e.id == hostelList.id ? hostelList : e)
              .toList(),
          filteredList: state.filteredList
              .map((e) => e.id == hostelList.id ? hostelList : e)
              .toList());
      CustomDialogs.toast(
          message: 'Hostel Status Updated Successfully',
          type: DialogType.success);
    } else {
      CustomDialogs.toast(
          message: 'Failed to Update Hostel Status',
          type: DialogType.error);
    }
  }
}

final adminRoomsStreamProvider = StreamProvider<List<RoomsModel>>((ref) async* {
  var data = RoomsServices.getAllRooms();
  var user = ref.read(userProvider);
  await for (var item in data) {
    ref.read(roomsFilterProvider.notifier).setItems(item, user);
    yield item;
  }
});

class RoomsFilter {
  List<RoomsModel> items;
  List<RoomsModel> filteredList;
  RoomsFilter({
    this.items = const [],
    this.filteredList = const [],
  });

  RoomsFilter copyWith({
    List<RoomsModel>? items,
    List<RoomsModel>? filteredList,
  }) {
    return RoomsFilter(
      items: items ?? this.items,
      filteredList: filteredList ?? this.filteredList,
    );
  }
}

final roomsFilterProvider =
    StateNotifierProvider<RoomsProvider, RoomsFilter>((ref) {
  return RoomsProvider();
});

class RoomsProvider extends StateNotifier<RoomsFilter> {
  RoomsProvider() : super(RoomsFilter(items: [], filteredList: []));
  void setItems(List<RoomsModel> items, UserModel user) {
    //order items by date
    items.sort((a, b) =>b.createdAt!=null&&a.createdAt!=null? b.createdAt!.compareTo(a.createdAt!):0);
    if (user.role == 'manager') {
      items = items.where((element) => element.managerId == user.id).toList();
    }
    state = state.copyWith(items: items, filteredList: items);
  }

  void filterRooms(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filteredList: state.items);
    } else {
      var filtered = state.items.where((element) {
        return element.title.toLowerCase().contains(query.toLowerCase()) ||
            element.hostelName.toLowerCase().contains(query.toLowerCase());
      }).toList();
      state = state.copyWith(filteredList: filtered);
    }
  }
   void filterRoomsByHostel(String value) {
    if (value.isEmpty) {
      state = RoomsFilter(items: state.items, filteredList: state.items);
      return;
    }
    state = RoomsFilter(
        items: state.items,
        filteredList: state.items
            .where((element) =>
                element.hostelName.toLowerCase() == value.toLowerCase())
            .toList());
  }
}
