import 'package:doctors_app/view/auth/phone.dart';
import 'package:doctors_app/view/register/signup_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RootElement extends StatelessWidget {
  const RootElement({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const SignupProfile();
        } else {
          return const PhoneNumberScreen();
        }
      },
    );
  }
}
