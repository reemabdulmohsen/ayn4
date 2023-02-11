import 'package:ayn3/Volunteer/auth/Login.dart';
import 'package:ayn3/Volunteer/auth/Signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showlogin = FirebaseAuth.instance.currentUser!.emailVerified;
  @override
  Widget build(BuildContext context) {
    if (showlogin) {
      return Login();
    } else {
      return SignUp();
    }
  }
}
