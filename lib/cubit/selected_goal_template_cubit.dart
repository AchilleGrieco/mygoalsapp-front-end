import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/model/goal_template.dart';

class SelectedGoalTemplateCubit extends Cubit<GoalTemplate?> {

  SelectedGoalTemplateCubit(GoalTemplate? goalTemplate) : super(null);

  void set(GoalTemplate? goalTemplate) {
    emit(goalTemplate);
  }
}