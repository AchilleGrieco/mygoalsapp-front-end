import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_goals/model/user.dart';

class UserCubit extends Cubit<User?> {
  UserCubit(User? user) : super(null);

  void set(User? user) {
    emit(user);
  }
}
