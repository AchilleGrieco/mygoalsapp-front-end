import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/goal_templates_cubit.dart';
import 'package:my_goals/cubit/goals_cubit.dart';
import 'package:my_goals/cubit/selected_goal_template_cubit.dart';
import 'package:my_goals/cubit/selected_icon_cubit.dart';
import 'package:my_goals/cubit/user_cubit.dart';
import 'package:my_goals/model/goal.dart';
import 'package:my_goals/model/goal_template.dart';
import 'package:my_goals/pages/g_nav_bar.dart';
import 'package:my_goals/pages/goal_templates/explore.dart';
import 'package:my_goals/pages/goals.dart';
import 'package:my_goals/pages/home.dart';
import 'package:my_goals/pages/profile.dart';
import 'package:my_goals/service/goal_service.dart';
import 'package:my_goals/service/goal_template_service.dart';

class ChooseTab extends StatelessWidget {
  ChooseTab({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    String token = context.read<UserCubit>().state!.token;
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([
          GoalTemplateService.getGoalTemplates(token),
          GoalService.getGoals(token)
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<GoalTemplate> goalTemplates = snapshot.data![0] as List<GoalTemplate>;
            List<Goal> goals = snapshot.data![1] as List<Goal>;
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => GoalTemplatesCubit(goalTemplates)),
                BlocProvider(create: (context) => SelectedIconCubit()),
                BlocProvider(create: (context) => GoalsCubit(goals)),
              ],
              child: Navigator(
                key: navigatorKey,
                initialRoute: '/home',
                onGenerateInitialRoutes: (navigator, initialRoute) {
                  return [
                    MaterialPageRoute(builder: (context) => const Home())
                  ];
                },
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case '/home':
                      builder = (BuildContext context) => const Home();
                      break;
                    case '/explore':
                      builder = (BuildContext context) => const Explore();
                      break;
                    case '/goals':
                      builder = (BuildContext context) =>  const Goals();
                      break;
                    default:
                      throw Exception('Invalid route: ${settings.name}');
                  }
                  return MaterialPageRoute(
                      builder: builder, settings: settings);
                },
              ),
            );
          }
          else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Error loading data',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text('Back to Login'),
                  ),
                ],
              ),
            );
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
      bottomNavigationBar: GNavBar(
        navigatorKey: navigatorKey,
      ),
    );
  }
}
