import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: null,
      child: Container(
        height: 180,
        width: 155,
        decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(18)),
            color: Colors.white),
        child: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Icon(Icons.more_vert)],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.run_circle,
                  size: 80,
                ),
                Text(
                  "Running",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "2 Times a Week",
                  style: TextStyle(fontSize: 12),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
