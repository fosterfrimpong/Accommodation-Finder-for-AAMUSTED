import 'package:js/js.dart';

@JS()
external paystackPopUp(
  String pkTest,
  String email,
  int amount,
  String ref,
  void Function() onClosed,
  void Function() callback,
);
