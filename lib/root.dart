import 'package:doctors_app/components/navigation.dart';
import 'package:doctors_app/view/auth/phone.dart';
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
          return const BottomNavbar();
        } else {
          return const PhoneNumberScreen();
        }
      },
    );
  }
}
