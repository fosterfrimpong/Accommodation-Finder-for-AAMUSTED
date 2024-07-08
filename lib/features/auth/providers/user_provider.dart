import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/features/auth/data/user_model.dart';
import 'package:unidwell_finder/features/auth/services/registration_services.dart';
import '../../local_storage.dart';

final userProvider = StateNotifierProvider<UserProvider, UserModel>((ref) {

  var user = LocalStorage.getData('user');
  if (user != null) {
    return UserProvider()..updateUer(UserModel.fromJson(user).id);
  }
  return UserProvider();
});

class UserProvider extends StateNotifier<UserModel> {
  UserProvider() : super(UserModel());

  void setUser(UserModel user) {
    LocalStorage.saveData('user', user.toJson());
    state = user;
  }

  void logout({required BuildContext context}) async {
    CustomDialogs.dismiss();
    CustomDialogs.loading(
      message: 'Logging out',
    );
    await RegistrationServices.signOut();
    state = UserModel();
    CustomDialogs.dismiss();
  }

  updateUer(String? id) async {
    var userData = await RegistrationServices.getUserData(id!);
    if (userData != null) {
      if (userData.status.toLowerCase() == 'banned') {
        LocalStorage.removeData('user');
        CustomDialogs.toast(
            message:
                'You are band from accessing this platform. Contact admin for more information',
            type: DialogType.error);
        return;
      }
      
      state = userData;
    }
  }
}
