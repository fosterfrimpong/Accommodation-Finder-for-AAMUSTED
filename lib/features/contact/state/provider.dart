
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/message_model.dart';

final newMessageProvider = StateNotifierProvider<NewMessage, ContactMessageModel>((ref) {
  return NewMessage();
});


class NewMessage extends StateNotifier<ContactMessageModel> {
  NewMessage() : super(ContactMessageModel());

  void setName(String? value) {
    state = state.copyWith(senderName:()=> value);
  }

  void setEmail(String? value) {
    state = state.copyWith(senderEmail:()=> value);
  }

  void setMessage(String? value) {
    state = state.copyWith(message:()=> value);
  }

  void sendMessage({required WidgetRef ref, required GlobalKey<FormState> form}) {}
}