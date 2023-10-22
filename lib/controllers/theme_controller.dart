import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;
  // late SharedPreferences prefs;

  Map<String, ThemeMode> themeModes = {
    'light': ThemeMode.light,
    'dark': ThemeMode.dark,
  };

  static ThemeController get to => Get.find();

  loadThemeMode() async {
    // prefs = await SharedPreferences.getInstance();
    // String themeText = prefs.getString('theme') ?? 'light';

    Directory dir = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox('preferences', path: dir.path);
    String themeText = box.get('theme') ?? 'light';
    isDark.value = themeText == 'dark' ? true : false;
    setMode(themeText);
  }

  Future setMode(String themeText) async {
    ThemeMode themeMode = themeModes[themeText]!;
    Get.changeThemeMode(themeMode);
    // prefs = await SharedPreferences.getInstance();
    // await prefs.setString('theme', themeText);

    var box = await Hive.openBox('preferences');
    await box.put('theme', themeText);
  }

  changeTheme() {
    setMode(isDark.value == true ? 'light' : 'dark');
    isDark.value = !isDark.value;
  }
}
