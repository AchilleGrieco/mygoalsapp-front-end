import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedIconCubit extends Cubit<int> {

  SelectedIconCubit({int? icon}) : super(icon ?? Icons.home.codePoint);

  void set(int icon) {
    emit(icon);
  }
}