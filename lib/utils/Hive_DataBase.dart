import 'package:hive_flutter/hive_flutter.dart';

class HiveDataBase {
  static late Box<String> accountBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    accountBox = await Hive.openBox<String>("Account");
  }

  static ({
    String userName,
    String type,
    String name,
    String seralNFC,

    String currentScreen
  }) getUserData() {
    String userName = accountBox.get("userName").toString();
    String type = accountBox.get("type").toString();
    String seralNFC = accountBox.get("seralNFC").toString();
    String name = accountBox.get("name").toString();
    String currentScreen = accountBox.get("currentScreen")??"0";

    return (

        userName:userName,
      type:type,
        seralNFC:seralNFC,
      name:name,
      currentScreen: currentScreen
    );
  }

  static setUserData(
      ({ String userName, String type, String syrialNFC, String name}) data) async {
    await accountBox.put("name", data.name);
    await accountBox.put("userName", data.userName);
    await accountBox.put("type", data.type);
    await accountBox.put("email", data.syrialNFC);
    return true;
  }





  static setCurrentScreen(String currentScreen) async {
    await accountBox.put("currentScreen", currentScreen);
    return true;
  }

  static deleteUserData() {
    accountBox.delete("mobile");
    accountBox.delete("name");
    accountBox.delete("gender");
    accountBox.delete("email");
    accountBox.delete("licenseImage");
    accountBox.delete("passport");
  }
}
