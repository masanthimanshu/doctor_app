import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalender extends StatefulWidget {
  const CustomCalender({super.key});

  @override
  State<CustomCalender> createState() => _CustomCalenderState();
}

class _CustomCalenderState extends State<CustomCalender> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      scrollDirection: Axis.horizontal,
      itemBuilder: (e, index) {
        final DateTime date = DateTime.now().add(Duration(days: index));
        final String week = DateFormat("E").format(date);
        final int dayNum = date.day;

        return Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                week,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == _selectedIndex
                        ? Colors.white
                        : Colors.white.withOpacity(0.25),
                  ),
                  child: Text(
                    dayNum.toString(),
                    style: TextStyle(
                      color:
                          index == _selectedIndex ? Colors.teal : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
