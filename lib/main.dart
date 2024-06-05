import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/goals_cubit.dart';
import 'package:my_goals/model/goal.dart';
import 'package:my_goals/pages/choose_tab.dart';
import 'package:my_goals/pages/log_in.dart';
import 'package:my_goals/pages/sign_up.dart';
import 'package:my_goals/service/goal_service.dart';

void main() async {
  List<Goal> goals = await GoalService().getGoals();
  runApp(BlocProvider(
    create: (context) => GoalsCubit(goals),
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
