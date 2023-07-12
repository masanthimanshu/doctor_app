import 'package:doctors_app/components/navigation.dart';
import 'package:doctors_app/firebase_options.dart';
import 'package:doctors_app/root.dart';
import 'package:doctors_app/utils/theme.dart';
import 'package:doctors_app/view/register/signup_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => const BottomNavbar(),
        "/register": (context) => const SignupProfile(),
      },
      theme: AppTheme.theme,
      home: const RootElement(),
    );
  }
}
