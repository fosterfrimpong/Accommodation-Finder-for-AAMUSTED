import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/features/hostels/data/hostels_model.dart';

final isNewHostel = StateProvider<bool>((ref) => false);
final isSearchingHostel = StateProvider<bool>((ref) => false);
final newHostelProvider =
    StateNotifierProvider<NewHostelProvider, HostelsModel>(
        (ref) => NewHostelProvider());

class NewHostelProvider extends StateNotifier<HostelsModel> {
  NewHostelProvider()
      : super(HostelsModel(
          name: '',
          location: '',
          description: '',
          images: [],
          managerId: '',
          managerName: '',
          managerEmail: '',
          createdAt: 0,
          id: '',
          lat: 0.0,
          lng: 0.0,
          managerPhone: '',
          school: '',
          status: '',
        ));

  void setHostelName(String name) {
    state = state.copyWith(name: name);
  }

  void setHostelLocation(String location) {
    state = state.copyWith(location: location);
  }

  void setHostelDescription(String description) {
    state = state.copyWith(description: description);
  }
}
