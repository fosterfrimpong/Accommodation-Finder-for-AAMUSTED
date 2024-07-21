import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/features/hostels/data/hostels_model.dart';
import 'package:unidwell_finder/features/rooms/data/rooms_model.dart';

final isSearchingRoomDashboardProvider = StateProvider<bool>((ref) => false);
final selectedHostelProvider = StateProvider<String>((ref) => '');

final newRoomProvider = StateNotifierProvider<NewRoomProvider, RoomsModel>(
    (ref) => NewRoomProvider());

class NewRoomProvider extends StateNotifier<RoomsModel> {
  NewRoomProvider()
      : super(RoomsModel(
          id: '',
        ));

  void setRoomTitle(String? value) {
    state = state.copyWith(title: value);
  }

  void setHostel(HostelsModel hostel) {
    state = state.copyWith(
      hostelId: hostel.id,
      hostelName: hostel.name,
      
    );
  }

  void setRoomDescription(String? value) {}

  void setRoomCapacity(String? capacity) {}

  void setRoomPrice(String? price) {}

  void setRoomType(value) {}

  void setBedType(value) {}

  void setBathroomType(value) {}

  void setKitchenType(value) {}

  void addFeature(String e) {}

  void removeFeature(String e) {}
}
