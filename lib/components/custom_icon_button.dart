import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.btnText,
    required this.iconData,
    required this.functionResponse,
  });

  final Icon iconData;
  final String btnText;
  final VoidCallback functionResponse;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: functionResponse,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal[200],
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: iconData,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(btnText),
        ],
      ),
    );
  }
}
