import 'package:hive_flutter/hive_flutter.dart';

class HiveDataBase {
  static late Box<String> accountBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    accountBox = await Hive.openBox<String>("Account");
  }

  static ({
    String name,
    String gender,
    String email,
    String mobile,
    String licenseImage,
    String passport,
    String location,
    String currentScreen
  }) getUserData() {
    String mobile = accountBox.get("mobile").toString();
    String name = accountBox.get("name").toString();
    String gender = accountBox.get("gender").toString();
    String email = accountBox.get("email").toString();
    String licenseImage = accountBox.get("licenseImage").toString();
    String passport = accountBox.get("passport").toString();
    String location = accountBox.get("location").toString();
    String currentScreen = accountBox.get("currentScreen")??"0";

    return (
      name: name,
      gender: gender,
      email: email,
      mobile: mobile,
      licenseImage: licenseImage,
      passport: passport,
      location: location,
      currentScreen: currentScreen
    );
  }

  static setUserData(
      ({String name, String gender, String email, String mobile}) data) async {
    await accountBox.put("mobile", data.mobile);
    await accountBox.put("name", data.name);
    await accountBox.put("gender", data.gender);
    await accountBox.put("email", data.email);
    return true;
  }

  static setUserPassPortData(String passport) async {
    await accountBox.put("passport", passport);
    return true;
  }

  static setUserLocationData(String location) async {
    await accountBox.put("location", location);
    return true;
  }

  static setUserLicenseImageData(String licenseImage) async {
    await accountBox.put("licenseImage", licenseImage);
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
