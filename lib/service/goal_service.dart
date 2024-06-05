import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:my_goals/config.dart';
import 'package:my_goals/model/goal.dart';

class GoalService {
  Future<List<Goal>> getGoals() async {
    Uri url = Uri.http(Config.apiUrl, "/getGoals");
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<Goal> goals = List.generate(data.length, (index) {
      return Goal(
          goalId: data[index].goalId,
          name: data[index].name,
          icon: data[index].icon);
    });
    return goals;
  }

  void addGoal(Goal goal) async {
    Uri url = Uri.http(Config.apiUrl, "/addGoal");
    final body = {"name": goal.name, "icon": goal.icon};
    final header = {"Content-Type": "application/json"};
    var response =
        await http.post(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  void removeGoal(Long goalId) async {
    Uri url = Uri.http(Config.apiUrl, "/removeGoal");
    final body = {"goalId": goalId};
    final header = {"Content-Type": "application/json"};
    var response =
        await http.delete(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  void modifyGoal(Goal goal) async {
    Uri url = Uri.http(Config.apiUrl, "/modifyGoal");
    final body = {"goalId": goal.goalId, "name": goal.name, "icon": goal.icon};
    final header = {"Content-Type": "application/json"};
    var response = await http.put(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception();
    }
  }
}
