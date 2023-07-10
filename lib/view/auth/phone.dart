import 'package:country_code_picker/country_code_picker.dart';
import 'package:doctors_app/view/auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final RegExp _numberPattern = RegExp(r'^\d{10}$');
  String _countryCode = "+91";
  String _phone = "";

  _handleSubmit() {
    if (_numberPattern.hasMatch(_phone)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpScreen(
            phoneNumber: _phone,
            countryCode: _countryCode,
          ),
        ),
      );
    } else if (_phone.trim() == "") {
      Fluttertoast.showToast(
        msg: "Enter Phone Number",
        backgroundColor: Colors.teal,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Invalid Phone Number",
        backgroundColor: Colors.teal,
      );
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
            color: Colors.teal,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Container(
            height: 225,
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
                const Text(
                  "Welcome User,",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
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
                      CountryCodePicker(
                        onChanged: (code) {
                          _countryCode = code.dialCode!;
                        },
                        favorite: const ["IN"],
                        initialSelection: "IN",
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (text) => _phone = text,
                          decoration: const InputDecoration(
                            hintText: "Phone",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    child: const Text("Next"),
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
