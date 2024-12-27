import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/model/goal_template.dart';
import 'package:my_goals/service/goal_template_service.dart';

class GoalTemplatesCubit extends Cubit<List<GoalTemplate>> {
  GoalTemplatesCubit(super.goalTemplates);

  GoalTemplateService goalTemplateService = GoalTemplateService();

  void addGoalTemplate(GoalTemplate goalTemplate, BuildContext context) async {
    final createdTemplate = await goalTemplateService.addGoalTemplate(goalTemplate, context);
    List<GoalTemplate> newState = List.from(state);
    newState.add(createdTemplate);  // Use the created template with the server-assigned ID
    emit(newState);
  }

  Future<void> removeGoalTemplate(GoalTemplate goalTemplate, BuildContext context) async{
    await goalTemplateService.removeGoalTemplate(goalTemplate.goalId!, context);
    List<GoalTemplate> newState = List.from(state);
    newState.remove(goalTemplate);
    emit(newState);
  }

  void modifyGoalTemplate(GoalTemplate goalTemplate, BuildContext context) async {
    await goalTemplateService.modifyGoalTemplate(goalTemplate, context);
    List<GoalTemplate> newState = List.from(state);
    int index = newState.indexOf(goalTemplate);
    newState.removeAt(index);
    newState.insert(index, goalTemplate);
    emit(newState);
  }
}
