import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/model/goal.dart';
import 'package:my_goals/service/goal_service.dart';

class GoalsCubit extends Cubit<List<Goal>> {
  GoalsCubit(List<Goal> goals) : super(goals);

  GoalService goalService = GoalService();

  void addGoal(Goal goal) {  // il metodo deve returnare il goal?
    goalService.addGoal(goal);
    state.add(goal);
    emit(state);
  }

  void removeGoal(Goal goal) {  // va inserito un try catch per l'exception del goalService?
    goalService.removeGoal(goal.goalId);
    state.remove(goal);
    emit(state);
  }

  void modifyGoal(Goal goal) {
    goalService.modifyGoal(goal);
    int index = state.indexOf(goal);
    state.removeAt(index);
    state.insert(index, goal);
    emit(state);
  }
}
