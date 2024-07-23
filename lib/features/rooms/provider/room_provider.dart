// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/features/hostels/data/hostels_model.dart';
import 'package:unidwell_finder/features/rooms/data/rooms_model.dart';
import 'package:unidwell_finder/features/rooms/services/rooms_services.dart';

import '../../auth/providers/user_provider.dart';

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
        lat: () => hostel.lat,
        lng: () => hostel.lng,
        institution: hostel.school);
  }

  void setRoomDescription(String? value) {
    state = state.copyWith(description: value);
  }

  void setRoomCapacity(String? capacity) {
    state = state.copyWith(
      capacity: int.parse(capacity!),
      availableSpace: int.parse(capacity),
    );
  }

  void setRoomPrice(String? price) {
    state = state.copyWith(price: double.parse(price!), additionalCost: 0);
  }

  void setRoomType(value) {
    state = state.copyWith(roomType: value);
  }

  void setBedType(value) {
    state = state.copyWith(bedType: value);
  }

  void setBathroomType(value) {
    state = state.copyWith(bathroomType: value);
  }

  void setKitchenType(value) {
    state = state.copyWith(kitchingType: value);
  }

  void addFeature(String e) {
    state = state.copyWith(features: [...state.features, e]);
  }

  void removeFeature(String e) {
    var features = state.features..remove(e);
    state = state.copyWith(features: features);
  }

  void addRule(String e) {
    state = state.copyWith(rules: [...state.rules, e]);
  }

  void removeRule(String e) {
    var rules = state.rules;
    rules.remove(e);
    state = state.copyWith(rules: rules);
  }

  void saveRoom({required WidgetRef ref, required BuildContext context}) async {
    CustomDialogs.loading(message: 'Saving room....');
    var images = ref.watch(roomImagesProvider);
    List<String> imageUrls = [];
    var id = RoomsServices.getId();
    if (images.isNotEmpty) {
      imageUrls = await RoomsServices.uploadRoomImages(images, id);
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
          message: 'Please add at least one image', type: DialogType.error);
      return;
    }
    if (imageUrls.isEmpty) {
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
          message: 'An error occured while uploading images',
          type: DialogType.error);
      return;
    }
    //clear images
    ref.read(roomImagesProvider.notifier).clearImages();
    var user = ref.read(userProvider);
    state = state.copyWith(
      id: id,
      images: imageUrls,
      managerEmail: user.email,
      managerId: user.id,
      managerName: user.name,
      status: 'available',
      managerPhone: user.phone,
      createdAt: () => DateTime.now().millisecondsSinceEpoch,
    );
    var result = await RoomsServices.saveRoom(state);
    if (result) {
      //pop page
      Navigator.pop(context);
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
          message: 'Room saved successfully', type: DialogType.success);
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
          message: 'An error occured while saving room',
          type: DialogType.error);
    }
  }
}

final editRoomProvider = StateNotifierProvider<EditRoomProvider, RoomsModel>(
    (ref) => EditRoomProvider());

class EditRoomProvider extends StateNotifier<RoomsModel> {
  EditRoomProvider()
      : super(RoomsModel(
          id: '',
        ));

  void setRoom(RoomsModel room) {
    state = room;
  }

  void setRoomTitle(String? value) {
    state = state.copyWith(title: value);
  }

  void setRoomDescription(String? value) {
    state = state.copyWith(description: value);
  }

  void setRoomCapacity(String? capacity) {
    state = state.copyWith(
      capacity: int.parse(capacity!),
      availableSpace: int.parse(capacity),
    );
  }

  void setRoomPrice(String? price) {
    state = state.copyWith(price: double.parse(price!), additionalCost: 0);
  }

  void setRoomType(value) {
    state = state.copyWith(roomType: value);
  }

  void setBedType(value) {
    state = state.copyWith(bedType: value);
  }

  void setBathroomType(value) {
    state = state.copyWith(bathroomType: value);
  }

  void setKitchenType(value) {
    state = state.copyWith(kitchingType: value);
  }

  void addFeature(String e) {
    state = state.copyWith(features: [...state.features, e]);
  }

  void removeFeature(String e) {
    var features = state.features..remove(e);
    state = state.copyWith(features: features);
  }

  void addRule(String e) {
    state = state.copyWith(rules: [...state.rules, e]);
  }

  void removeRule(String e) {
    var rules = state.rules;
    rules.remove(e);
    state = state.copyWith(rules: rules);
  }

  void updateRoom({required WidgetRef ref, required BuildContext context}) async {
    CustomDialogs.loading(message: 'Updating room....');
    var images = ref.watch(roomImagesProvider);
    List<String> imageUrls = state.images;
    var id = state.id;
    if (images.isNotEmpty) {
      imageUrls = await RoomsServices.uploadRoomImages(images, id);
       state = state.copyWith(
        images: imageUrls,
      );
    } 
    
    //clear images
    ref.read(roomImagesProvider.notifier).clearImages();
    var result = await RoomsServices.updateRoom(room: state);
    if (result) {
      //pop page
      Navigator.pop(context);
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
          message: 'Room Updated successfully', type: DialogType.success);
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
          message: 'An error occured while Updating room',
          type: DialogType.error);
    }
  }
}

final roomImagesProvider =
    StateNotifierProvider<RoomImages, List<Uint8List>>((ref) => RoomImages());

class RoomImages extends StateNotifier<List<Uint8List>> {
  RoomImages() : super([]);

  void addImage(Uint8List image) {
    state = [...state, image];
  }

  void removeImage(int index) {
    var images = state;
    images.removeAt(index);
    state = [...images];
  }

  void clearImages() {
    state = [];
  }
}
