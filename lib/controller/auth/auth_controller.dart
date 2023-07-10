import 'package:doctors_app/components/navigation.dart';
import 'package:doctors_app/view/auth/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void sendOtp({
    required BuildContext context,
    required String countryCode,
    required String phoneNumber,
  }) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: "$countryCode $phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        codeSent: ((String verificationId, int? resendToken) async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpScreen(
                verId: verificationId,
                phoneNumber: phoneNumber,
                countryCode: countryCode,
              ),
            ),
          );
        }),
        verificationFailed: (e) => throw Exception(e.message),
        codeAutoRetrievalTimeout: (String verificationId) {
          Fluttertoast.showToast(msg: "OTP Timed Out");
        },
      );
    } on FirebaseAuthException {
      Fluttertoast.showToast(msg: "Error Sending OTP");
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );

      await auth.signInWithCredential(credential).then((value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const BottomNavbar()),
          ModalRoute.withName('/home'),
        );
      }).catchError((e) => throw Exception(e.message));
    } on FirebaseAuthException {
      Fluttertoast.showToast(msg: "Error Verifying OTP");
    }
  }
}
