import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _completedKey = "completed_exercise";

  Future<void> markExerciseCompleted(String id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> completedList = prefs.getStringList(_completedKey) ?? [];
    completedList.add(id);
    await prefs.setStringList(_completedKey, completedList);
  }
  Future<List<String>> getCompletedExercise() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_completedKey) ?? [];
  }
}