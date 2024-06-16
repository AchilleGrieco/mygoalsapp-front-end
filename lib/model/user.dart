import 'dart:ffi';

class User {
  final Long userId;
  final String username;
  final String email;
  final String token;

  User(
      {required this.userId,
      required this.username,
      required this.email,
      required this.token});
}
