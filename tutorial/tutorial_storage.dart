import 'package:shared_preferences/shared_preferences.dart';

class TutorialStorage {
  static const _prefix = 'practiva_tutorial_';

  Future<bool> isCompleted(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_prefix$id') ?? false;
  }

  Future<void> markCompleted(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_prefix$id', true);
  }

  Future<void> reset(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefix$id');
  }
}