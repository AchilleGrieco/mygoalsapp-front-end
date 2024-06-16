import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:my_goals/config.dart';
import 'package:my_goals/model/goal_template.dart';

class GoalTemplateService {
  Future<List<GoalTemplate>> getGoalTemplates() async {
    Uri url = Uri.http(Config.apiUrl, "/getGoals");
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<GoalTemplate> goals = List.generate(data.length, (index) {
      return GoalTemplate(
          goalId: data[index].goalId,
          name: data[index].name,
          icon: data[index].icon);
    });
    return goals;
  }

  void addGoalTemplate(GoalTemplate goalTemplate) async {
    Uri url = Uri.http(Config.apiUrl, "/addGoal");
    final body = {"name": goalTemplate.name, "icon": goalTemplate.icon};
    final header = {"Content-Type": "application/json"};
    var response =
        await http.post(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  void removeGoalTemplate(Long goalId) async {
    Uri url = Uri.http(Config.apiUrl, "/removeGoal");
    final body = {"goalId": goalId};
    final header = {"Content-Type": "application/json"};
    var response =
        await http.delete(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  void modifyGoalTemplate(GoalTemplate goalTemplate) async {
    Uri url = Uri.http(Config.apiUrl, "/modifyGoal");
    final body = {"goalId": goalTemplate.goalId, "name": goalTemplate.name, "icon": goalTemplate.icon};
    final header = {"Content-Type": "application/json"};
    var response = await http.put(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
