import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/goal_templates_cubit.dart';
import 'package:my_goals/cubit/selected_icon_cubit.dart';
import 'package:my_goals/cubit/user_cubit.dart';
import 'package:my_goals/pages/g_nav_bar.dart';
import 'package:my_goals/pages/goal_templates/explore.dart';
import 'package:my_goals/pages/goals.dart';
import 'package:my_goals/pages/home.dart';
import 'package:my_goals/pages/profile.dart';
import 'package:my_goals/service/goal_template_service.dart';

class ChooseTab extends StatelessWidget {
  ChooseTab({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    String token = context.read<UserCubit>().state!.token;
    return Scaffold(
      body: FutureBuilder(
        future: GoalTemplateService.getGoalTemplates(token),
        builder: (context, snapshot) {
        
          if (snapshot.hasData) {
            return BlocProvider(
              create: (context) => GoalTemplatesCubit(snapshot.data!),
              child: BlocProvider(
                create: (context) => SelectedIconCubit(null),
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
                        builder = (BuildContext context) => const Goals();
                        break;
                      case '/profile':
                        builder = (BuildContext context) => const Profile();
                        break;
                      default:
                        throw Exception('Invalid route: ${settings.name}');
                    }
                    return MaterialPageRoute(
                        builder: builder, settings: settings);
                  },
                ),
              ),
            );
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: GNavBar(
        navigatorKey: navigatorKey,
      ),
    );
  }
}
