import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/features/hostels/data/hostels_model.dart';

final isSearchingHostel = StateProvider<bool>((ref) => false);
final newHostelProvider =
    StateNotifierProvider<NewHostelProvider, HostelsModel>(
        (ref) => NewHostelProvider());

class NewHostelProvider extends StateNotifier<HostelsModel> {
  NewHostelProvider()
      : super(HostelsModel(
          id: '',
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


final hostelImagesProvider = StateProvider<List<Uint8List>>((ref) => []);