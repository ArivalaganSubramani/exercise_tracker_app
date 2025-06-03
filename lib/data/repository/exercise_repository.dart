import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/exercise_model.dart';

class ExerciseRepository {
  Future<List<Exercise>> fetchExercises() async {
    final uri =
    Uri.parse('https://68252ec20f0188d7e72c394f.mockapi.io/dev/workouts');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Exercise.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load exercises');
    }
  }
}