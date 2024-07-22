import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/core/functions/view_on_map.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/features/hostels/data/hostels_model.dart';
import 'package:unidwell_finder/features/hostels/services/hostel_services.dart';
import 'package:unidwell_finder/features/institutions/data/institutions_model.dart';

import '../../auth/providers/user_provider.dart';

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

  void setSchool(InstitutionsModel school) {
    state = state.copyWith(school: school.name, schoolId: school.id);
  }

  void setLatitude(String s) {
    state = state.copyWith(lat: double.parse(s));
  }

  void setLongitude(String s) {
    state = state.copyWith(lng: double.parse(s));
  }

  void getLocation() async {
    CustomDialogs.loading(
      message: 'Getting location',
    );
    var positionn = await determinePosition();
    CustomDialogs.dismiss();
    if (positionn != null) {
      state = state.copyWith(lat: positionn.latitude, lng: positionn.longitude);
    }
  }

  void saveHostel(
      {required BuildContext context, required WidgetRef ref}) async {
    CustomDialogs.loading(message: 'Saving hostel');
    var id = HostelServices.getId();
    var images = ref.read(hostelImagesProvider);
     List<String> imageUrls = [];
    if(images.isEmpty){
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(message: 'Please add at least one image',type: DialogType.error);
      return;
    }else{
        imageUrls = await HostelServices.uploadImages(images, id);
    }
    if (imageUrls.isEmpty) {
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
          message: 'An error occured while uploading images',
          type: DialogType.error);
      return;
    }
    //clear images
    ref.read(hostelImagesProvider.notifier).clear();
    var user = ref.read(userProvider);
    state = state.copyWith(images: imageUrls,
    id: id,
    createdAt:()=> DateTime.now().millisecondsSinceEpoch,
    managerEmail: user.email,
    managerId: user.id,
    managerName: user.name,
    managerPhone: user.phone,
    status: 'opened',
    );
    var result = await HostelServices.addHostel(state);
    CustomDialogs.dismiss();
    if (result) {
      CustomDialogs.showDialog(
          message: 'Hostel added successfully', type: DialogType.success);
      Navigator.pop(context);
    } else {
      CustomDialogs.showDialog(
          message: 'An error occured while adding hostel',
          type: DialogType.error);
    }
  }
}


final editHostelProvider =
    StateNotifierProvider<EditHostelProvider, HostelsModel>(
        (ref) => EditHostelProvider());

class EditHostelProvider extends StateNotifier<HostelsModel> {
  EditHostelProvider()
      : super(HostelsModel(
          id: '',
        ));

     void   setHostel(HostelsModel hostel){
          state = hostel;
        }

  void setHostelName(String name) {
    state = state.copyWith(name: name);
  }

  void setHostelLocation(String location) {
    state = state.copyWith(location: location);
  }

  void setHostelDescription(String description) {
    state = state.copyWith(description: description);
  }

  void setSchool(InstitutionsModel school) {
    state = state.copyWith(school: school.name, schoolId: school.id);
  }

  void setLatitude(String s) {
    state = state.copyWith(lat: double.parse(s));
  }

  void setLongitude(String s) {
    state = state.copyWith(lng: double.parse(s));
  }

  void getLocation() async {
    CustomDialogs.loading(
      message: 'Getting location',
    );
    var positionn = await determinePosition();
    CustomDialogs.dismiss();
    if (positionn != null) {
      state = state.copyWith(lat: positionn.latitude, lng: positionn.longitude);
    }
  }

  void updateHoste(
      {required BuildContext context, required WidgetRef ref}) async {
    CustomDialogs.loading(message: 'Saving hostel');
    var id = HostelServices.getId();
    var images = ref.read(hostelImagesProvider);
    List<String> imageUrls = [];
    if (images.isNotEmpty) {
      imageUrls = await HostelServices.uploadImages(images, id);
      state = state.copyWith(
        images: imageUrls,
      );
    }
    
    //clear images
    ref.read(hostelImagesProvider.notifier).clear();
    
    var result = await HostelServices.updateHostel(state);
    CustomDialogs.dismiss();
    if (result) {
      CustomDialogs.showDialog(
          message: 'Hostel updated successfully', type: DialogType.success);
      Navigator.pop(context);
    } else {
      CustomDialogs.showDialog(
          message: 'An error occured while updating hostel',
          type: DialogType.error);
    }
  }
}


final hostelImagesProvider =
    StateNotifierProvider<HostelImages, List<Uint8List>>(
        (ref) => HostelImages());

class HostelImages extends StateNotifier<List<Uint8List>> {
  HostelImages() : super([]);

  void addImage(Uint8List image) {
    state = [...state, image];
  }

  void removeImage(int index) {
    var images = state;
    images.removeAt(index);
    state = [...images];
  }
  
  void clear() {
    state = [];
  }
}
