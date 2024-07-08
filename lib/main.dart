import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:unidwell_finder/config/routes/router.dart';
import 'package:unidwell_finder/features/local_storage.dart';
import 'package:unidwell_finder/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //remove hashbang from url
  await LocalStorage.initData();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Unidwell Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      builder: FlutterSmartDialog.init(),
      routerConfig: MyRouter(ref: ref, context: context).router(),
    );
  }

  
}
