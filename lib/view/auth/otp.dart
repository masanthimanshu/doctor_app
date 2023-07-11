import 'package:doctors_app/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.verId,
    required this.countryCode,
    required this.phoneNumber,
  });

  final String verId;
  final String countryCode;
  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final RegExp _otpPattern = RegExp(r'^\d{6}$');
  String _otp = "";

  _handleSubmit() {
    if (_otpPattern.hasMatch(_otp)) {
      AuthRepository().verifyOTP(
        userOTP: _otp,
        context: context,
        verificationId: widget.verId,
      );
    } else if (_otp.trim() == "") {
      Fluttertoast.showToast(msg: "Enter Your OTP");
    } else {
      Fluttertoast.showToast(msg: "Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            height: 50,
            color: Colors.teal.shade800,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              color: Colors.teal.shade800,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Container(
            height: 325,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(20, 75, 20, 0),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 5,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.countryCode} - ${widget.phoneNumber}",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.teal.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Change")),
                  ],
                ),
                Text(
                  "Enter 6 digit otp sent on phone number \n ${widget.countryCode} - ${widget.phoneNumber}",
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (text) => _otp = text,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: "Enter OTP",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    child: const Text("Submit"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Resend OTP"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
