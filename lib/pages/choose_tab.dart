import 'package:flutter/material.dart';
import 'package:my_goals/pages/g_nav_bar.dart';
import 'package:my_goals/pages/explore.dart';
import 'package:my_goals/pages/goals.dart';
import 'package:my_goals/pages/home.dart';
import 'package:my_goals/pages/profile.dart';

class ChooseTab extends StatefulWidget {
  const ChooseTab({super.key});

  @override
  State<ChooseTab> createState() => _ChooseTabState();
}

class _ChooseTabState extends State<ChooseTab> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
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
              builder = (BuildContext context) => Goals();
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
      bottomNavigationBar: GNavBar(navigatorKey: navigatorKey,),
    );
  }
}