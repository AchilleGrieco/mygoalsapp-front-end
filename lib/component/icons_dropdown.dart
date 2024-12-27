import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/selected_icon_cubit.dart';
import 'package:my_goals/model/goal.dart';
import 'package:my_goals/model/goal_template.dart';

class IconsDropDown extends StatefulWidget {
  IconsDropDown({super.key, this.goalTemplate});

  final GoalTemplate? goalTemplate;

  int? selectedCodePoint;

  @override
  State<IconsDropDown> createState() => _IconsDropDownState();
}

class _IconsDropDownState extends State<IconsDropDown> {

  final Map<int, String> icons = {
    Icons.home.codePoint: 'home',
    Icons.star.codePoint: 'star',
    Icons.settings.codePoint: 'settings',
    Icons.search.codePoint: 'search',
    Icons.camera.codePoint: 'camera',
    Icons.map.codePoint: 'map',
    Icons.favorite.codePoint: 'favorite',
    Icons.person.codePoint: 'person',
  };



  

  @override
  Widget build(BuildContext context) {
  
    return DropdownMenu<int>(
      initialSelection: widget.goalTemplate != null ? int.parse(widget.goalTemplate!.icon) : context.read<SelectedIconCubit>().state,
      onSelected: (value) {
        context.read<SelectedIconCubit>().set(value!);
        widget.selectedCodePoint = value;
      },
      dropdownMenuEntries: List.generate(icons.length, (index) {
        return DropdownMenuEntry(value: icons.keys.toList()[index], label: icons.values.toList()[index]);
      }),
    );
  }
} 