import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:my_goals/config.dart';
import 'package:my_goals/model/goal.dart';
import 'package:my_goals/service/authentication_service.dart';

class GoalService {

  final String token = AuthenticationService().token;
  late Map<String, Object> queryParams;
  
  Future<List<Goal>> getGoals() async {
    Uri url = Uri.http(Config.apiUrl, "/getGoals");
    final header = {
      "authentication" : token
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode != 200) {
      throw Exception();
    }
    final data = jsonDecode(response.body);
    List<Goal> goals = List.generate(data.length, (index) {
      return Goal(goalId: data[index].goalId, name: data[index].name, icon: data[index].icon, frequency: data[index].frequency);
    });
    return goals;
  }

  Future<Goal> addGoal(Goal goal) async {
    Uri url = Uri.http(Config.apiUrl, "/addGoal");
    final body = {
      "name": goal.name,
      "icon": goal.icon,
      "frequency": goal.frequency
    };
    final header = {"Content-Type": "application/json",
    "authentication" : token};
    final response =
        await http.post(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 201) {
      throw Exception();
    }
    final data = jsonDecode(response.body);
    return Goal(goalId: data.goalId, name: data.name, icon: data.icon, frequency: data.frequency);
  }

  void removeGoal(Long goalId) async {
    queryParams["param1"] = goalId;
    Uri url = Uri.http(Config.apiUrl, "/removeGoal", queryParams);
    final header = {
      "authentication" : token
    };
    final response = await http.delete(url, headers: header);
    if (response.statusCode != 204) {
      throw Exception();
    }
  }

  Future<Goal> modifyGoal(Goal goal) async {
    Uri url = Uri.http(Config.apiUrl, "/modifyGoal");
    final body = {
      "goalId" : goal.goalId,
      "name" : goal.name,
      "icon" : goal.icon,
      "frequency" : goal.frequency
    };
    final header = {
      "Content-Type": "application/json",
      "authentication" : token
    };
    final response = await http.put(url, headers: header, body: body);
    if (response.statusCode != 200) {
      throw Exception(); 
    }
    final data = jsonDecode(response.body);
    return Goal(goalId: data.goalId, name: data.name, icon: data.icon, frequency: data.frequency);
  }


}
