import 'package:ayn3/contsants.dart';
import 'package:ayn3/firebase_storge_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../Volunteer/auth/main_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ayn3/blind/descPage.dart';

import '../controller/controller.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _link = TextEditingController();
  List Links = [];
  int? NumOfImage;
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[color_blue, color_purple],
  ).createShader(const Rect.fromLTWH(0.10, 0.30, 200.0, 70.0));

  @override
  void initState() {
   NumOfImage = 0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<Controller>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //title
                        const Text('مرحبًا بك في عين',
                            style: TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.bold,
                                fontSize: 40)),
                        const SizedBox(
                          height: 10,
                        ),
                        //h2
                        const Text('شاركنا رابط التغريدة',
                            style: TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.w200,
                                fontSize: 25)),
                        const SizedBox(
                          height: 10,
                        ),
                        //tweet link
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueGrey[50],
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: TextField(
                                controller: _link,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: "PNU",
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "رابط التغريدة",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    gradient: const LinearGradient(
                      begin: Alignment(-0.95, 0.0),
                      end: Alignment(1.0, 0.0),
                      colors: [color_blue, color_purple],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      fetchData(pro);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    child: const Text(
                      "طلب وصف",
                      style: TextStyle(fontFamily: "PNU", color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 160,
                ),
                Container(
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables, duplicate_ignore, duplicate_ignore
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      //thank you
                      const Text('شكراً لاستخدامك تطبيق عين',
                          style: TextStyle(
                            fontFamily: "PNU",
                            fontSize: 20,
                          )),
                      //sign in
                      // ignore: prefer_const_constructors

                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()),
                            );
                          },
                          child: Text(
                            'تسجيل دخول كمتطوع',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "PNU",
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linearGradient),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          pro.isLoading
              ? Lottie.network(
                  "https://assets7.lottiefiles.com/packages/lf20_rwq6ciql.json")
              : Container(),
        ],
      ),
    );
  }

  Future<String> getImagesIDs() async {
    Reference image = FirebaseStorage.instance.ref("Images");
    final url = image.child("image2.png").fullPath;

    print(url.toString());
    return url;
  }

  Future fetchData(var pro) async {
    pro.changeLoading(true);
    String ans = "";
    try {
      final response = await http.get(Uri.parse(
          "http://reemabdulmohsen.pythonanywhere.com/link/?link=${_link.text.trim()}"));
      final decoded = (json.decode(response.body) as Map).map((key, value) =>
          MapEntry(key as String, value as Map<String, dynamic>));
      print(decoded["1"]);


      if (decoded.length > 1) {
        print("here");
        ans = "في التغريدة ${decoded.length} صور. ";
        for (var i in decoded.keys) {
          NumOfImage=NumOfImage!+1;
         await FirebaseFirestore.instance
              .collection("User")
              .doc("AI")
              .collection("desc")
              .where('link', isEqualTo: decoded[i]!["link"])
              .get()
              .then((element) {
              element.docs.forEach((val) {

                Links.add(val.id);

            });
          });
          ans += "صورة رقم $i : ${decoded[i]!["desc"]}. ";
        if(!Links.isNotEmpty){
          addDescinDB(decoded[i]!["link"], decoded[i]!["desc"]);
        }}
        DescPage.desc = ans;
      } else {
        if (decoded.length == 1) {
          print("888888888888");
          NumOfImage!=1;
          await FirebaseFirestore.instance
              .collection("User")
              .doc("AI")
              .collection("desc")
              .where('link', isEqualTo: decoded['1']!["link"])
              .get()
              .then((element) {
                print("7777777777777");
            element.docs.forEach((val) {
              print("66666666666");
              Links.add(val.id);

            });
          });
          print("lllllllllllllllllllll");
          print(Links);
          ans += "صورة رقم 1 : ${decoded['1']!["desc"]}. ";
          DescPage.desc = ans;
          if(!Links.isNotEmpty){
            print("55555555");
              ans = "في التغريدة صورة واحدة: ";
              ans += decoded["1"]!["desc"];
              DescPage.desc = ans;
            addDescinDB(decoded['1']!["link"], decoded['1']!["desc"]);
          }
        //   ans = "في التغريدة صورة واحدة: ";
        //   ans += decoded["1"]!["desc"];
        //   DescPage.desc = ans;
        //   addDescinDB(decoded["1"]!["link"], decoded["1"]!["desc"]);
        } else {
          ans = "التغريدة لا تحتوي على صور";
          DescPage.desc = ans;
        }}

    } catch (e) {
      DescPage.desc = e.toString();
    }
    pro.changeLoading(false);
    print(NumOfImage);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DescPage(numOfImage: NumOfImage!, links: Links)),
    );
  }

  addDescinDB(String link, String desc) async {
    String docId = FirebaseFirestore.instance
        .collection('User')
        .doc("AI")
        .collection("desc")
        .doc()
        .id;
    await FirebaseFirestore.instance
        .collection('User')
        .doc("AI")
        .collection("desc")
        .doc(docId)
        .set({
      "desc": desc,
      "rate": 0.0,
      "link": link,
      "id": docId,
      "ListOfRates": {},
      "ListOfUser": []
    });
  }
}
