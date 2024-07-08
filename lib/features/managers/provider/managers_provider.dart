import 'package:flutter_riverpod/flutter_riverpod.dart';

final isSearchingManagers = StateProvider<bool>((ref) {
  return false;
});
