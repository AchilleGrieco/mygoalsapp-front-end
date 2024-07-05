import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:my_goals/config.dart';
import 'package:my_goals/cubit/user_cubit.dart';
import 'package:my_goals/model/goal_template.dart';

class GoalTemplateService {
  late Map<String, Object> queryParams;

  Future<List<GoalTemplate>> getGoalTemplates(BuildContext context) async {
    String token = context.read<UserCubit>().state!.token;
    Uri url = Uri.http(Config.apiUrl, "/getGoals");
    final header = {"authentication": token};
    final response = await http.get(url, headers: header);
    if (response.statusCode != 200) {
      throw Exception();
    }
    final data = jsonDecode(response.body);
    List<GoalTemplate> goals = List.generate(data.length, (index) {
      return GoalTemplate(
          goalId: data[index].goalId,
          name: data[index].name,
          icon: data[index].icon);
    });
    return goals;
  }

  Future<GoalTemplate> addGoalTemplate(
      GoalTemplate goalTemplate, BuildContext context) async {
    String token = context.read<UserCubit>().state!.token;
    Uri url = Uri.http(Config.apiUrl, "/addGoal");
    final body = {"name": goalTemplate.name, "icon": goalTemplate.icon};
    final header = {
      "Content-Type": "application/json",
      "authentication": token
    };
    var response =
        await http.post(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 201) {
      throw Exception();
    }
    final data = jsonDecode(response.body);
    return GoalTemplate(goalId: data.goalId, name: data.name, icon: data.icon);
  }

  void removeGoalTemplate(Long? goalId, BuildContext context) async {
    String token = context.read<UserCubit>().state!.token;
    queryParams["param1"] = goalId!;
    Uri url = Uri.http(Config.apiUrl, "/removeGoal", queryParams);
    final header = {
      "Content-Type": "application/json",
      "authentication": token
    };
    var response = await http.delete(url, headers: header);
    if (response.statusCode != 204) {
      throw Exception();
    }
  }

  Future<GoalTemplate> modifyGoalTemplate(
      GoalTemplate goalTemplate, BuildContext context) async {
    String token = context.read<UserCubit>().state!.token;
    Uri url = Uri.http(Config.apiUrl, "/modifyGoal");
    final body = {
      "goalId": goalTemplate.goalId,
      "name": goalTemplate.name,
      "icon": goalTemplate.icon
    };
    final header = {
      "Content-Type": "application/json",
      "authentication": token
    };
    var response = await http.put(url, headers: header, body: jsonEncode(body));
    if (response.statusCode != 200) {
      throw Exception();
    }
    final data = jsonDecode(response.body);
    return GoalTemplate(goalId: data.goalId, name: data.name, icon: data.icon);
  }
}
