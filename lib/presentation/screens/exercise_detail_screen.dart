import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../../data/models/exercise_model.dart';
import '../../data/repository/local_storage.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final Exercise exercise;
  final LocalStorage localStorage = LocalStorage();

  ExerciseDetailScreen({super.key, required this.exercise});

  @override
  _ExerciseDetailScreenState createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  late StopWatchTimer _stopWatchTimer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: widget.exercise.duration * 1000,
      onEnded: () async {
        await widget.localStorage.markExerciseCompleted(widget.exercise.id);
        Navigator.pop(context);
      },
    );
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    _stopWatchTimer.onStartTimer();
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
    });
    _stopWatchTimer.onStopTimer();
  }

  void _resetTimer() {
    _stopWatchTimer.onResetTimer();
    setState(() {
      _isRunning = false;
    });
    _stopWatchTimer.onResetTimer();
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.exercise.name)),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.exercise.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                widget.exercise.description,
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: widget.exercise.duration * 1000,
                builder: (context, snapshot) {
                  final displayTime =
                  StopWatchTimer.getDisplayTime(snapshot.data ?? 0,
                      hours: false, milliSecond: false);
                  return Text(
                    "Time Remaining: $displayTime",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  );
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isRunning ? _pauseTimer : _startTimer,
                    icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                    label: Text(_isRunning ? "Pause" : "Start"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton.icon(
                    onPressed: _resetTimer,
                    icon: Icon(Icons.replay),
                    label: Text("Reset"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}