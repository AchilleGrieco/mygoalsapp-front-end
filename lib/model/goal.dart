import 'dart:ffi';

import 'package:flutter/material.dart';

class Goal {

  final Long goalId;
  final String name;
  final Icon icon;

  Goal({required this.goalId, required this.name, required this.icon});

}