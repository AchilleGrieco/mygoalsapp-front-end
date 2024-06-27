import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedIconCubit extends Cubit<IconData?> {

  SelectedIconCubit(IconData? icon) : super(null);

  void set(IconData? icon) {
    emit(icon);
  }
}