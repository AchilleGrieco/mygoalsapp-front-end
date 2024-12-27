import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:my_goals/service/authentication_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  String errorMessage = "";

  // Helper method to check if all fields are filled
  bool allFieldsFilled() {
    return emailController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        repeatPasswordController.text.isNotEmpty;
  }

  // Helper method to validate all fields and update error message
  void validateFields() {
    setState(() {
      if (!allFieldsFilled()) {
        errorMessage = "All fields are required";
      } else if (!emailController.text.contains('@')) {
        errorMessage = "Email must contain '@'";
      } else if (emailController.text.split('@').length > 2) {
        errorMessage = "Email cannot contain multiple '@' symbols";
      } else if (passwordController.text != repeatPasswordController.text) {
        errorMessage = "Passwords don't match";
      } else {
        errorMessage = "";
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 40, 50, 20),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.more_horiz,
                    size: 32,
                  )
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Image.asset(
                'assets/target_image.png',
                height: 120,
                width: 120,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "my",
                    style: TextStyle(fontSize: 36, color: Colors.white),
                  ),
                  Text(
                    "goals",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: emailController,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                onChanged: (text) {
                  validateFields();
                },
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white)),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: usernameController,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  LengthLimitingTextInputFormatter(14),
                ],
                onChanged: (text) {
                  validateFields();
                },
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.white)),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(32),
                ],
                onChanged: (text) {
                  validateFields();
                },
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white)),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (text) {
                  validateFields();
                },
                controller: repeatPasswordController,
                obscureText: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(32),
                ],
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelText: 'Repeat password',
                    labelStyle: TextStyle(color: Colors.white)),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 3,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 140,
                height: 50,
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                    gradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.greenAccent])),
                child: ElevatedButton(
                  onPressed: () async {
                    validateFields();
                    if (errorMessage.isNotEmpty) {
                      return;
                    }

                    try {
                      await AuthenticationService()
                          .register(emailController.text,
                              usernameController.text, passwordController.text);
                      Navigator.pop(context);
                    } catch (error) {
                      setState(() {
                        errorMessage = error.toString().replaceAll('Exception: ', '');
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                'Already have an account?',
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
