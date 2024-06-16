import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/goal_templates_cubit.dart';
import 'package:my_goals/model/goal_template.dart';
import 'package:my_goals/pages/choose_tab.dart';
import 'package:my_goals/pages/log_in.dart';
import 'package:my_goals/pages/sign_up.dart';
import 'package:my_goals/service/goal_template_service.dart';

void main() async {
  List<GoalTemplate> goalTemplates = await GoalTemplateService().getGoalTemplates();
  runApp(BlocProvider(
    create: (context) => GoalTemplatesCubit(goalTemplates),
    child: MaterialApp(
      initialRoute: '/login',
      routes: {
        '/signup': (context) => const SignUp(),
        '/login': (context) => const LogIn(),
        '/choosetab': (context) => const ChooseTab()
      },
    ),
  ));
}
