import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unidwell_finder/firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

class LocalStorage {
  static Future<void> initData() async {
    //remove hashbang from url
    await Hive.initFlutter();
    //open local storage box
    await Hive.openBox('unidwell_finder');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    setPathUrlStrategy();
  }

  //save data to local storage
  static void saveData(String key, String value) async{
    await Hive.box('unidwell_finder').put(key, value);
  }

  //get data from local storage
  static String? getData(String key) {
    return Hive.box('unidwell_finder').get(key);
  }

  //remove data from local storage
  static void removeData(String key) async{
    await Hive.box('unidwell_finder').delete(key);
  }
}
