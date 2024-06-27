import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/cubit/selected_icon_cubit.dart';
import 'package:my_goals/model/goal_template.dart';

class IconsDropDown extends StatefulWidget {
  const IconsDropDown({super.key, this.goalTemplate});

  final GoalTemplate? goalTemplate;

  @override
  State<IconsDropDown> createState() => _IconsDropDownState();
}

class _IconsDropDownState extends State<IconsDropDown> {

  final Map<IconData, String> icons = {
    Icons.home: 'home',
    Icons.star: 'star',
    Icons.settings: 'settings',
    Icons.search: 'search',
    Icons.camera: 'camera',
    Icons.map: 'map',
    Icons.favorite: 'favorite',
    Icons.person: 'person',
  };


  @override
  Widget build(BuildContext context) {
    return DropdownMenu<IconData>(
      initialSelection: IconData(widget.goalTemplate?.icon as int),
      onSelected: (value) {
        context.read<SelectedIconCubit>().set(value);
      },
      dropdownMenuEntries: List.generate(icons.length, (index) {
        return DropdownMenuEntry(value: icons.keys.toList()[index], label: icons.values.toList()[index]);
      }),
    );
  }
}