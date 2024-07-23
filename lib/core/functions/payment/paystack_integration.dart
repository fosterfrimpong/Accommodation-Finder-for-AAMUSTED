// // ignore: avoid_web_libraries_in_flutter

// library callable_function;
// import 'package:js/js.dart' as js;
// import 'package:unidwell_finder/core/constatnts/paystack_keys.dart';
// import '../payment/paystack_interop.dart' as paystack;

// class PaystackPopup {
//   static Future<void> openPaystackPopup({
//     required String email,
//     required int amount,
//     required String ref,
//     required void Function() onClosed,
//     required void Function() onSuccess,
//   }) async {
//     js.allowInterop(
//       paystack.paystackPopUp(
//         testPublicKey,
//         email,
//         amount,
//         ref,
//         js.allowInterop(
//           onClosed,
//         ),
//         js.allowInterop(
//           onSuccess,
//         ),
//       ),
//     );
//   }
// }
