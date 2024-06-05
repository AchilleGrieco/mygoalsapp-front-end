import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/model/choosed_goal.dart';
import 'package:my_goals/service/choosed_goal_service.dart';

class ChoosedGoalsCubit extends Cubit<List<ChoosedGoal>> {
  ChoosedGoalsCubit(List<ChoosedGoal> choosedGoals) : super(choosedGoals);

  ChoosedGoalService choosedGoalService = ChoosedGoalService();

  void addChoosedGoal(ChoosedGoal choosedGoal) {
    choosedGoalService.addChoosedGoal(choosedGoal);
    state.add(choosedGoal);
    emit(state);
  }
}
