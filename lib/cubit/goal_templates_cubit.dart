

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/model/goal_template.dart';
import 'package:my_goals/service/goal_template_service.dart';

class GoalTemplatesCubit extends Cubit<List<GoalTemplate>>{

  GoalTemplatesCubit(List<GoalTemplate> goalTemplates) : super(goalTemplates);

  GoalTemplateService goalTemplateService = GoalTemplateService();

  void addGoal(GoalTemplate goalTemplate) {
    goalTemplateService.addGoalTemplate(goalTemplate);
    state.add(goalTemplate);
    emit(state);
  }

  void removeGoal(GoalTemplate goalTemplate) {
    goalTemplateService.removeGoalTemplate(goalTemplate.goalId);
    state.remove(goalTemplate);
    emit(state);
  }

  void modifyGoal(GoalTemplate goalTemplate) {
    goalTemplateService.modifyGoalTemplate(goalTemplate);
    int index = state.indexOf(goalTemplate);
    state.removeAt(index);
    state.insert(index, goalTemplate);
    emit(state);
  }

}