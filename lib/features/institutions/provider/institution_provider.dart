import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/features/institutions/data/institutions_model.dart';
import 'package:unidwell_finder/features/institutions/services/institution_services.dart';

import '../data/institution_filter_model.dart';

final instituionStream =
    StreamProvider.autoDispose<List<InstitutionsModel>>((ref) async* {
  var institutions = InstitutionServices.getInstitutions();
  await for (var institution in institutions) {
    ref.read(institutionsProvider.notifier).setItems(institution);
    yield institution;
  }
});

final institutionsProvider =
    StateNotifierProvider<InstitutionProvider, InstitutionFilterModel>((ref) {
  return InstitutionProvider();
});

class InstitutionProvider extends StateNotifier<InstitutionFilterModel> {
  InstitutionProvider()
      : super(InstitutionFilterModel(items: [], filteredItems: []));

  void setItems(List<InstitutionsModel> items) {
    state = InstitutionFilterModel(items: items, filteredItems: items);
  }

  void filterItems(String query) {
    if (query.isEmpty) {
      state = InstitutionFilterModel(
          items: state.items, filteredItems: state.items);
    } else {
      var filteredItems = state.items
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = InstitutionFilterModel(
          items: state.items, filteredItems: filteredItems);
    }
  }

  void deleteInstitution(InstitutionsModel item)async {
    CustomDialogs.dismiss();
    CustomDialogs.loading(message: 'Deleting school..');
    var result = await InstitutionServices.deleteInstitution(item);
    if (result) {
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'Institution Deleted Successfully', type: DialogType.success);
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
          message: 'Failed to Delete Institution', type: DialogType.error);
    }
  }

  void updateInstitution(WidgetRef ref) async {
    CustomDialogs.dismiss();
    CustomDialogs.loading(message: 'Updating Institution..');
    var newItem = ref.watch(selectedInstitutionProvider);
    if (newItem != null) {
      var result = await InstitutionServices.updateInstitution(newItem);
      if (result) {
        CustomDialogs.dismiss();
        CustomDialogs.toast(
            message: 'Institution Updated Successfully',
            type: DialogType.success);
        ref.read(selectedInstitutionProvider.notifier).removeItem();
      } else {
        CustomDialogs.dismiss();
        CustomDialogs.showDialog(
            message: 'Failed to Update Institution', type: DialogType.error);
      }
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
          message: 'Failed to Update Institution', type: DialogType.error);
    }
  }
}

final selectedInstitutionProvider =
    StateNotifierProvider<SelectedInstitution, InstitutionsModel?>(
        (ref) => SelectedInstitution());

class SelectedInstitution extends StateNotifier<InstitutionsModel?> {
  SelectedInstitution() : super(null);

  void selectInstitution(InstitutionsModel item) {
    state = item;
  }

  void removeItem() {
    state = null;
  }

  void setLong(double parse) {
    state = state!.copyWith(long: parse);
  }

  void setLoction(String value) {
    state = state!.copyWith(location: value);
  }

  void setLat(double parse) {
    state = state!.copyWith(lat: parse);
  }

  void setName(String value) {
    state = state!.copyWith(name: value);
  }
}

final newInstitutionProvider =
    StateNotifierProvider<NewInstitutionProvider, InstitutionsModel>((ref) {
  return NewInstitutionProvider();
});

class NewInstitutionProvider extends StateNotifier<InstitutionsModel> {
  NewInstitutionProvider()
      : super(InstitutionsModel(
          id: '',
          name: '',
          location: '',
          lat: 0.0,
          long: 0.0,
        ));

  void setLong(double parse) {
    state = state.copyWith(long: parse);
  }

  void setLoction(String value) {
    state = state.copyWith(location: value);
  }

  void setLat(double parse) {
    state = state.copyWith(lat: parse);
  }

  void setName(String value) {
    state = state.copyWith(name: value);
  }

  void saveInstitution(WidgetRef ref) async {
    CustomDialogs.loading(message: 'Saving Institution..');
    //check if the institution is already saved
    var existing = ref
        .read(institutionsProvider)
        .items
        .where((element) =>
            element.name.toLowerCase().trim().replaceAll(' ', '') == state.name)
        .toList();
    if (existing.isNotEmpty) {
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
          message: 'Institution Already Exists', type: DialogType.error);
      return;
    }
    state = state.copyWith(id: InstitutionServices.getInstitutionId());
    var result = await InstitutionServices.addInstitution(state);
    if (result) {
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'Institution Saved Successfully', type: DialogType.success);
      reset();
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.showDialog(
          message: 'Failed to Save Institution', type: DialogType.error);
    }
  }

  void reset() {
    state = InstitutionsModel(
      id: '',
      name: '',
      location: '',
      lat: 0.0,
      long: 0.0,
    );
  }
}


final isSearching = StateProvider<bool>((ref) => false);
final isNew = StateProvider<bool>((ref) => false);