import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unidwell_finder/config/routes/router.dart';
import 'package:unidwell_finder/core/views/custom_dialog.dart';
import 'package:unidwell_finder/features/auth/services/registration_services.dart';
import '../../../config/routes/router_item.dart';
import '../data/user_model.dart';

final userRegistrationProvider =
    StateNotifierProvider<UserRegistrationProvider, UserModel>((ref) {
  return UserRegistrationProvider();
});

class UserRegistrationProvider extends StateNotifier<UserModel> {
  UserRegistrationProvider() : super(UserModel());

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: () => password);
  }

  void setUserRole(String? value) {
    state = state.copyWith(role: value);
  }

  void setName(String s) {
    state = state.copyWith(name: s);
  }

  void setGender(value) {
    state = state.copyWith(gender: value);
  }

  void setPhone(String s) {
    state = state.copyWith(phone: s);
  }

  setInstitution(value) {
    state = state.copyWith(school: value);
  }

  void reset() {
    state = UserModel();
  }

  void createNewUser(
      {required WidgetRef ref, required BuildContext context}) async {
    CustomDialogs.loading(message: 'Creating account...');
    state = state.copyWith(
        status: 'active',
        createdAt: () => DateTime.now().millisecondsSinceEpoch,
        id: RegistrationServices.getId());
    var (message, createdUser) = await RegistrationServices.registerUser(state);
    if (createdUser != null) {
      await RegistrationServices.signOut();
      ref.read(userRegistrationProvider.notifier).reset();
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: '$message. Please verify your email',
          type: DialogType.success);
      MyRouter(context: context, ref: ref)
          .navigateToRoute(RouterItem.loginRoute);
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.toast(message: message, type: DialogType.error);
    }
  }
}
