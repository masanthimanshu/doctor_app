import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:doctors_app/view/home/appointments.dart';
import 'package:doctors_app/view/home/doctors.dart';
import 'package:doctors_app/view/home/home.dart';
import 'package:doctors_app/view/home/settings.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  final List _pages = [
    const HomeScreen(),
    const DoctorsScreen(),
    const AppointmentsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70,
              color: Colors.teal.shade800,
            ),
            _pages[_selectedIndex],
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.grey.shade300,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home,
            color: _selectedIndex == 0 ? Colors.amber.shade800 : Colors.black,
          ),
          Icon(
            Icons.list_alt_sharp,
            color: _selectedIndex == 1 ? Colors.amber.shade800 : Colors.black,
          ),
          Icon(
            Icons.calendar_month,
            color: _selectedIndex == 2 ? Colors.amber.shade800 : Colors.black,
          ),
          Icon(
            Icons.settings,
            color: _selectedIndex == 3 ? Colors.amber.shade800 : Colors.black,
          ),
        ],
      ),
    );
  }
}
