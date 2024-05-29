import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/model/goal.dart';

class GoalsCubit extends Cubit<List<Goal>>{

  GoalsCubit(List<Goal> goals) : super(goals);

  void addGoal(Goal goal) {
    state.add(goal);
    emit(state);
  }

  void removeGoal(Goal goal) {
    state.remove(goal);
    emit(state);
  }

}