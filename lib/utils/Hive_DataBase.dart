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
      { required String userName,required String type, required String serialNFC,required String name}) async {
    await accountBox.put("name",name);
    await accountBox.put("userName", userName);
    await accountBox.put("type", type);
    await accountBox.put("email", serialNFC);
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
