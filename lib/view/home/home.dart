import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_app/components/custom_calander.dart';
import 'package:doctors_app/components/custom_icon_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _userId = FirebaseAuth.instance.currentUser!.uid;

  dynamic _firebaseData = {};
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _db.collection("users").doc(_userId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            color: Colors.teal.shade800,
          );
        }

        _firebaseData = snapshot.data?.data();

        return Column(
          children: [
            Container(
              color: Colors.teal.shade800,
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "👋 Hello,",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _firebaseData["name"],
                        style: const TextStyle(
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
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            _firebaseData["image"],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.teal.shade800,
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
              color: Colors.teal.shade800,
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
                  Text(
                    "Services",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal.shade800,
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
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (e, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Symptoms of Covid to watch out for.",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "June 05, 09:10 PM",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              "https://www.paho.org/sites/default/files/styles/max_1500x1500/public/2021-01/covid-19-vaccination-1500-991-2.jpg",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
