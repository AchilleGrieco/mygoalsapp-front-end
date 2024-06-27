import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/goal_templates_cubit.dart';
import 'package:my_goals/cubit/selected_icon_cubit.dart';
import 'package:my_goals/model/goal_template.dart';
import 'package:my_goals/pages/g_nav_bar.dart';
import 'package:my_goals/pages/goal_templates/explore.dart';
import 'package:my_goals/pages/goals.dart';
import 'package:my_goals/pages/home.dart';
import 'package:my_goals/pages/profile.dart';
import 'package:my_goals/service/goal_template_service.dart';

class ChooseTab extends StatefulWidget {
  const ChooseTab({super.key});

  @override
  State<ChooseTab> createState() => _ChooseTabState();
}

class _ChooseTabState extends State<ChooseTab> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<List<GoalTemplate>> chargeGoalTemplates() async {
    List<GoalTemplate> goalTemplates = await GoalTemplateService().getGoalTemplates();
    return goalTemplates;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => GoalTemplatesCubit(chargeGoalTemplates() as List<GoalTemplate>),
        child: BlocProvider(
          create: (context) => SelectedIconCubit(null),
          child: Navigator(
            key: navigatorKey,
            initialRoute: '/home',
            onGenerateInitialRoutes: (navigator, initialRoute) {
              return [MaterialPageRoute(builder: (context) => const Home())];
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
                  builder = (BuildContext context) => const Goals();
                  break;
                case '/profile':
                  builder = (BuildContext context) => const Profile();
                  break;
                default:
                  throw Exception('Invalid route: ${settings.name}');
              }
              return MaterialPageRoute(builder: builder, settings: settings);
            },
          ),
        ),
      ),
      bottomNavigationBar: GNavBar(
        navigatorKey: navigatorKey,
      ),
    );
  }
}
