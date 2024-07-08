import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unidwell_finder/features/auth/providers/user_provider.dart';
import 'package:unidwell_finder/features/auth/services/registration_services.dart';
import 'package:unidwell_finder/features/local_storage.dart';

import '../../../config/routes/router.dart';
import '../../../config/routes/router_item.dart';
import '../../../core/views/custom_dialog.dart';
import '../data/login_model.dart';
import '../data/user_model.dart';

final loginProvider = StateNotifierProvider<LoginProvider, LoginModel>((ref) {
  return LoginProvider();
});

class LoginProvider extends StateNotifier<LoginModel> {
  LoginProvider() : super(LoginModel(email: '', password: ''));

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void login({required WidgetRef ref, required BuildContext context}) async {
    CustomDialogs.loading(
      message: 'Logging in',
    );
    var (message, user) =
        await RegistrationServices.loginUser(state.email, state.password);
    if (user != null) {
      var userData = await RegistrationServices.getUserData(user.uid);
      if (userData != null) {
        if (userData.status.toLowerCase() == 'banned') {
          LocalStorage.removeData('user');
          CustomDialogs.dismiss();
          CustomDialogs.toast(
              message:
                  'You are band from accessing this platform. Contact admin for more information',
              type: DialogType.error);
          return;
        }
        if (user.emailVerified ||
            userData.role == 'admin' ||
            userData.email.contains('fusekoda') ||
            userData.email.contains('koda.')) {
          CustomDialogs.dismiss();
          //get user from database

          ref.read(userProvider.notifier).setUser(userData);

          // ignore: use_build_context_synchronously
          MyRouter(context: context, ref: ref)
              .navigateToRoute(RouterItem.homeRoute);
        } else {
          CustomDialogs.dismiss();
          CustomDialogs.showDialog(
              message: 'Email is not verified',
              type: DialogType.info,
              secondBtnText: 'Send Verification',
              onConfirm: () async {
                await user.sendEmailVerification();
                CustomDialogs.dismiss();
              });
        }
      } else {
        CustomDialogs.dismiss();
        CustomDialogs.toast(message: 'User not found', type: DialogType.error);
      }
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.toast(message: message, type: DialogType.error);
    }
  }
}

final selectedimageProvider = StateProvider<Uint8List?>((ref) {
  return null;
});

final udateUserProvider = StateNotifierProvider<UpdateUser, UserModel>((ref) {
  return UpdateUser();
});

class UpdateUser extends StateNotifier<UserModel> {
  UpdateUser() : super(UserModel());

  void setUser(UserModel user) {
    if (state.id.isEmpty) {
      state = user;
    }
  }

  void setName(String value) {
    state = state.copyWith(name: value);
  }

  void setGender(String? value) {
    state = state.copyWith(gender: value);
  }

  void setEmail(String s) {
    state = state.copyWith(email: s);
  }

  void changeImage(WidgetRef ref) {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) async {
      if (value != null) {
        ref.read(selectedimageProvider.notifier).state =
            await value.readAsBytes();
      }
    });
  }

  void updateUser(
      {required BuildContext context, required WidgetRef ref}) async {
    CustomDialogs.dismiss();
    CustomDialogs.dismiss();
    CustomDialogs.loading(
      message: 'Updating user',
    );
    //upload image if image is selected
    var image = ref.watch(selectedimageProvider);
    if (image != null) {
      var url = await RegistrationServices.uploadImage(image);
      if (url.isNotEmpty) {
        state = state.copyWith(image: () => url);
        ref.read(selectedimageProvider.notifier).state = null;
      } else {
        CustomDialogs.toast(
            message: 'Image upload failed', type: DialogType.error);
        return;
      }
    }
    //update user
    var result = await RegistrationServices.updateUser(state);
    if (result) {
      //save user data to local storage
      // Storage localStorage = window.localStorage;
      // localStorage['user'] = state.toJson();
      ref.read(userProvider.notifier).setUser(state);
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'User updated successfully', type: DialogType.success);
    } else {
      CustomDialogs.dismiss();
      CustomDialogs.toast(
          message: 'User update failed', type: DialogType.error);
    }
  }
}
