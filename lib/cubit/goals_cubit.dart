import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/model/goal.dart';
import 'package:my_goals/service/goal_service.dart';

class GoalsCubit extends Cubit<List<Goal>> {
  GoalsCubit(super.goals);

  GoalService goalService = GoalService();

  void addGoal(Goal goal, BuildContext context) {
    // il metodo deve returnare il goal?
    goalService.addGoal(goal, context);
    state.add(goal);
    emit(state);
  }

  void removeGoal(Goal goal, BuildContext context) {
    // va inserito un try catch per l'exception del goalService?
    goalService.removeGoal(goal.goalId!, context);
    state.remove(goal);
    emit(state);
  }

  void modifyGoal(Goal goal, BuildContext context) {
    goalService.modifyGoal(goal, context);
    int index = state.indexOf(goal);
    state.removeAt(index);
    state.insert(index, goal);
    emit(state);
  }
}
