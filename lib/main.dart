import 'package:LiftOn/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/viewmodels/exercise_bloc.dart';
import 'data/repository/exercise_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ExerciseRepository repository = ExerciseRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseBloc(repository)..add(LoadExercises()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}