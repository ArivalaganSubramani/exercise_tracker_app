import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../viewmodels/exercise_bloc.dart';
import '../widgets/exercise_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercise Tracker')),
      body: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          if (state is ExerciseLoading) {
            return Center(child: CircularProgressIndicator());
          }else if(state is ExerciseLoaded){
            return ListView.builder(
              itemCount: state.exercises.length,
              itemBuilder: (context, index) {
                return ExerciseCard(exercise: state.exercises[index]);
                },
            );
          }else if (state is ExerciseError) {
            return Center(child: Text('Erro: ${state.message}'));
          }
          return Container();
        },
      )
    );
  }
}
