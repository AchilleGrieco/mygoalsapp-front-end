

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/model/goal_template.dart';
import 'package:my_goals/service/goal_template_service.dart';

class GoalTemplatesCubit extends Cubit<List<GoalTemplate>>{

  GoalTemplatesCubit(super.goalTemplates);

  GoalTemplateService goalTemplateService = GoalTemplateService();

  void addGoalTemplate(GoalTemplate goalTemplate) { // il metodo deve returnare il goalTemplate?
    goalTemplateService.addGoalTemplate(goalTemplate);
    state.add(goalTemplate);
    emit(state);
  }

  void removeGoalTemplate(GoalTemplate goalTemplate) { // va inserito un try catch per l'exception del goalService?
    goalTemplateService.removeGoalTemplate(goalTemplate.goalId);
    state.remove(goalTemplate);
    emit(state);
  }

  void modifyGoalTemplate(GoalTemplate goalTemplate) {
    goalTemplateService.modifyGoalTemplate(goalTemplate);
    int index = state.indexOf(goalTemplate);
    state.removeAt(index);
    state.insert(index, goalTemplate);
    emit(state);
  }

}