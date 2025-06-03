import 'package:flutter/material.dart';
import '../../data/models/exercise_model.dart';
import '../../data/repository/local_storage.dart';
import '../screens/exercise_detail_screen.dart';

class ExerciseCard extends StatefulWidget {
  final Exercise exercise;

  const ExerciseCard({super.key, required this.exercise});

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}
class _ExerciseCardState extends State<ExerciseCard> {
  final LocalStorage localStorage = LocalStorage();
  bool isCompleted = false;

  @override
  void initState(){
    super.initState();
    _loadCompletionStatus();
  }
  void _loadCompletionStatus() async {
    List<String> completedExercises = await localStorage.getCompletedExercise();
    setState(() {
      isCompleted = completedExercises.contains(widget.exercise.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          widget.exercise.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Duration: ${widget.exercise.duration} sec"),
        trailing: Icon(
          isCompleted ? Icons.check_circle : Icons.play_circle_fill,
          color: isCompleted ? Colors.green : Colors.blue,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExerciseDetailScreen(exercise: widget.exercise)
            ),
          ).then((_){
            _loadCompletionStatus();
          }) ;
        },
      ),
    );
  }
}
