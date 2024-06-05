import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_goals/config.dart';
import 'package:my_goals/model/choosed_goal.dart';
import 'package:my_goals/model/goal.dart';

class ChoosedGoalService {
  Future<List<ChoosedGoal>> getChoosedGoals() async {
    Uri url = Uri.http(Config.apiUrl, "/getChoosedGoal");
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<ChoosedGoal> choosedGoals = List.generate(data.length, (index) {
      return ChoosedGoal(
          choosedGoalId: data[index].choosedGoalId,
          goal: Goal(
              goalId: data[index].goalId,
              name: data[index].name,
              icon: data[index].icon),
          frequency: data[index].frequency);
    });
    return choosedGoals;
  }

  void addChoosedGoal(ChoosedGoal choosedGoal) async {
    Uri url = Uri.http(Config.apiUrl, "/addChoosedGoal");
    final body = {
      "name": choosedGoal.goal.name,
      "icon": choosedGoal.goal.icon,
      "frequency": choosedGoal.frequency
    };
    final header = {"Content-Type": "application/json"};
    var response =
        await http.post(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
