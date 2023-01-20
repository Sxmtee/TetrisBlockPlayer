import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalSettings extends ChangeNotifier {
  GlobalSettings._();

  bool _soundOn = true;
  bool _musicOn = true;
  bool _vibrationOn = true;

  static Future<GlobalSettings> initNew() async {

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Not clean but only happens once at startup, exactly whats needed
      await DesktopWindow.setWindowSize(const Size(400, 700));
      // DesktopWindow.setMaxWindowSize(const Size(400, 700));
      DesktopWindow.setMinWindowSize(const Size(400, 700));
    }

    var preferences = await SharedPreferences.getInstance();

    GlobalSettings settings = GlobalSettings._();

    settings._musicOn = preferences.getBool('musicOn') ?? true;
    settings._soundOn = preferences.getBool('soundOn') ?? true;
    settings._vibrationOn = preferences.getBool('vibrationOn') ?? true;

    return settings;
  }

  bool get soundOn => _soundOn;

  bool get musicOn => _musicOn;

  bool get vibrationOn => _vibrationOn;

  set vibrationOn(bool value) {
    _vibrationOn = value;
    notifyListeners();
    SharedPreferences.getInstance().then((preferences) => preferences.setBool('vibrationOn', value));
  }

  set musicOn(bool value) {
    _musicOn = value;
    notifyListeners();
    SharedPreferences.getInstance().then((preferences) => preferences.setBool('musicOn', value));
  }

  set soundOn(bool value) {
    _soundOn = value;
    notifyListeners();
    SharedPreferences.getInstance().then((preferences) => preferences.setBool('soundOn', value));
  }
}
