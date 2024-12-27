import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:google_nav_bar/google_nav_bar.dart';

class GNavBar extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const GNavBar({super.key, required this.navigatorKey});

  @override
  State<GNavBar> createState() => _GNavBarState();
}

class _GNavBarState extends State<GNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            selectedIndex: currentIndex,
            onTabChange: (index) {
              if (index == 0) {
                widget.navigatorKey.currentState?.pushNamed('/home');
                setState(() {
                  currentIndex = index;
                });
              }
              if (index == 1) {
                widget.navigatorKey.currentState?.pushNamed('/explore');
                setState(() {
                  currentIndex = index;
                });
              }
              if (index == 2) {
                widget.navigatorKey.currentState?.pushNamed('/goals');
                setState(() {
                  currentIndex = index;
                });
              }
            },
            gap: 8,
            tabBackgroundColor: Colors.grey.shade300,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(icon: Icons.track_changes_outlined, text: 'Explore'),
              GButton(icon: Icons.star, text: 'Goals'),
            ],
          ),
        ),
      ),
    );
  }
}
