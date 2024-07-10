// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:unidwell_finder/core/constatnts/paystack_keys.dart';
import '../payment/paystack_interop.dart' as paystack;

class PaystackPopup {
  static Future<void> openPaystackPopup({
    required String email,
    required int amount,
    required String ref,
    required void Function() onClosed,
    required void Function() onSuccess,
  }) async {
    js.context.callMethod(
      paystack.paystackPopUp(
        testPublicKey,
        email,
        amount,
        ref,
        js.allowInterop(
          onClosed,
        ),
        js.allowInterop(
          onSuccess,
        ),
      ),
      [],
    );
  }
}
