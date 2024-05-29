
import 'package:flutter/material.dart';
import 'package:my_goals/pages/choosed_goal_card.dart';

class Goals extends StatelessWidget {
  const Goals({super.key});


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset('assets/bg.jpg', fit: BoxFit.fill,)),
        const Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.fromLTRB(30, 40, 30, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Goals", style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          ChoosedGoalCard()
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      Column(
                        children: [
                          ChoosedGoalCard()
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // elenco di goalCards
        )
      ]
    );
  }
}