// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:ayn3/Volunteer/dashboardV/navbar.dart';
import 'package:ayn3/contsants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ayn3/Volunteer/dashboardV/VolTask.dart';

class homepagev extends StatefulWidget {
  static int DescNum = 0;
  static int RateNum = 0;
  static bool pressed = false;
  // ignore: non_constant_identifier_names
  static int TaskIndex = 0;

  const homepagev({super.key});

  @override
  State<homepagev> createState() => homepagevState();
}

class homepagevState extends State<homepagev> {
  String name = "";

  Future _getData() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (!mounted) return;
      if (value.exists) {
        setState(() {
          name = value.data()!["name"];
        });
      }
    });
  }

  Future _getDescNum() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (!mounted) return;
      if (value.exists) {
        setState(() {
          homepagev.DescNum = value.data()!["desc_num"];
        });
      }
    });
  }

  Future _getRateNum() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (!mounted) return;
      if (value.exists) {

        setState(() {
          homepagev.RateNum = value.data()!["rate_num"];
        });
      }
    });
  }

  final List tasks = [
    ["الصور المطلوب وصفها", "asset/static/add.png", 3],
    ["مكتبة الصورة الخاصة بك", "asset/static/image-7.png", 1],
    ["تقييم الوصف الآلي", "asset/static/star.png", 4]
  ];
  @override
  Widget build(BuildContext context) {
    _getData();
    _getDescNum();
    _getRateNum();
    return parchisWitget(context);
  }

  Widget parchisWitget(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Padding(
      padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          IconButton(
            alignment: Alignment.topRight,
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          SizedBox(
              height: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                     Text("أهلا " + name!,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontSize: 30,
                            fontFamily: "PNU",
                            fontWeight: FontWeight.bold))
                  ])), // Text Top

          Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: Row(children: const <Widget>[
                Text("المهام",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "PNU",
                        fontWeight: FontWeight.bold))
              ])),

          SizedBox(
              height: 140,
              child: ListView.builder(
                  itemCount: tasks.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return VolTask(
                        TaskName: tasks[index][0],
                        TaskIcon: tasks[index][1],
                        TaskPage: tasks[index][2]);
                  })),

          const SizedBox(
            height: 25,
          ),

          Container(
            alignment: Alignment.centerRight,
            child: const Text(
              "الاحصائيات",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 20, fontFamily: "PNU", fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient:
                    const LinearGradient(colors: [color_blue, color_purple])),
            padding: const EdgeInsets.all(20),
            child: Text(
              "عدد الصور الموصوفة: ${homepagev.DescNum}",
              style: const TextStyle(
                  fontFamily: "PNU", color: Colors.white, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient:
                    const LinearGradient(colors: [color_blue, color_purple])),
            padding: const EdgeInsets.all(20),
            child: Text(
              "عدد الصور المقيمة: ${homepagev.RateNum}",
              style: const TextStyle(
                  fontFamily: "PNU", color: Colors.white, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
