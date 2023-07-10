import 'package:doctors_app/components/custom_calander.dart';
import 'package:doctors_app/components/custom_icon_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.teal,
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "👋 Hello,",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "User Name",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.teal,
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(250),
            ),
            child: TextField(
              onChanged: (text) => _searchQuery = text,
              decoration: const InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                icon: Icon(Icons.search_rounded),
              ),
            ),
          ),
        ),
        Container(
          height: 100,
          color: Colors.teal,
          child: const CustomCalender(),
        ),
        Container(
          height: 10,
          color: Colors.grey[200],
          width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Services",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("See All"),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              CustomIconButton(
                btnText: "Covid-19",
                iconData: const Icon(Icons.coronavirus),
                functionResponse: () {
                  debugPrint("Response 1");
                },
              ),
              CustomIconButton(
                btnText: "Doctors",
                iconData: const Icon(Icons.person),
                functionResponse: () {
                  debugPrint("Response 2");
                },
              ),
              CustomIconButton(
                btnText: "Hospitals",
                iconData: const Icon(Icons.local_hospital_outlined),
                functionResponse: () {
                  debugPrint("Response 3");
                },
              ),
              CustomIconButton(
                btnText: "Medicines",
                iconData: const Icon(Icons.medication),
                functionResponse: () {
                  debugPrint("Response 4");
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 10,
          color: Colors.grey[200],
          width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Daily Reports",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.indigo[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
        ListView.builder(
          itemCount: 20,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (e, index) {
            return Container(
              height: 20,
              color: Colors.blue,
            );
          },
        ),
      ],
    );
  }
}
