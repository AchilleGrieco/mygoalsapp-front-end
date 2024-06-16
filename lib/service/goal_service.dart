import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_goals/config.dart';
import 'package:my_goals/model/goal.dart';
import 'package:my_goals/model/goal_template.dart';

class GoalService {
  Future<List<Goal>> getGoals() async {
    Uri url = Uri.http(Config.apiUrl, "/getGoals");
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<Goal> goals = List.generate(data.length, (index) {
      return Goal(
          goalId: data[index].choosedGoalId,
          goalTemplate: GoalTemplate(
              goalId: data[index].goalId,
              name: data[index].name,
              icon: data[index].icon),
          frequency: data[index].frequency);
    });
    return goals;
  }

  void addGoal(Goal goal) async {
    Uri url = Uri.http(Config.apiUrl, "/addGoal");
    final body = {
      "name": goal.goalTemplate.name,
      "icon": goal.goalTemplate.icon,
      "frequency": goal.frequency
    };
    final header = {"Content-Type": "application/json"};
    var response =
        await http.post(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
