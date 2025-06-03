import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/exercise_model.dart';
import '../../data/repository/exercise_repository.dart';

sealed class ExerciseState {}

class ExerciseLoading extends ExerciseState {}

class ExerciseLoaded extends ExerciseState{
  final List<Exercise> exercises;
  ExerciseLoaded(this.exercises);
}

class ExerciseError extends ExerciseState {
  final String message;
  ExerciseError(this.message);
}

sealed class ExerciseEvent {}

class LoadExercises extends ExerciseEvent {}
 class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository repository;

  ExerciseBloc(this.repository): super(ExerciseLoading()) {
    on<LoadExercises>((event,emit)async{
      try{
        final exercises = await repository.fetchExercises();
        emit(ExerciseLoaded(exercises));
      } catch(e){
        emit(ExerciseError(e.toString()));
      }
    });
  }
 }