import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../contsants.dart';
import 'MainPage.dart';
import 'Profile.dart';

class ChangeName extends StatefulWidget {
  @override
  State<ChangeName> createState() => ChangeNameState();
}

class ChangeNameState extends State<ChangeName> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _name = TextEditingController();
    return MainPageState.indexSettings == 1
        ? Profile()
        : Container(
      padding: EdgeInsets.only(top: 60, right: 20,left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
            alignment: Alignment.topRight,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: (() => setState(() {
              MainPageState.indexSettings = 1;
            })),
          ),
          Container(
            child: const Text(
              "تغيير أسم المستخدم",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: "PNU",
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            child: const Text(
              "أدخل أسم المستخدم الجديد",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                fontFamily: "PNU",
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.0),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          borderRadius: BorderRadius.circular(60)),
                      child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: TextField(
                              controller: _name,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "أسم المستخدم",
                                hintStyle: TextStyle(
                                    fontFamily: "PNU", fontSize: 15),
                              )
                          )
                      )
                  )
              ),
              const SizedBox(
                height: 20,
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
                    resetName(_name.text.trim());
                  },
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      shadowColor:
                      MaterialStateProperty.all(Colors.transparent)),
                  child: const Text(
                    "حفظ",
                    style:
                    TextStyle(fontFamily: "PNU", color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Map errors = { "invalid-email": "البريد الإلكتروني غير صحيح" , "requires-recent-login": "حصل خطأ.. حاول مجدداً" , "email-already-in-use" : "البريد الإلكتروني مستخدم من قبل"};
  Future resetName(String newName) async {
    try{
      final user = await FirebaseAuth.instance.currentUser;

      if (user != null) {
        if(newName.isEmpty){
          throw ("null");
        }
        await FirebaseFirestore.instance.collection('User').doc(
            user.uid).set({"name": newName});

      }
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
        content:   Text(
          "تم تحديث أسم المستخدم بنجاح! ",
          textAlign: TextAlign.left,
          style: TextStyle(fontFamily: "PNU", color: Colors.white),
        ),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.green,
      ));

    }  catch(e){
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
        content:  Text(
          "لا يوجد اسم مدخل",
          textAlign: TextAlign.left,
          style: const TextStyle(fontFamily: "PNU", color: Colors.white),
        ),
        duration:const  Duration(seconds: 5),
        backgroundColor: const Color.fromARGB(255, 163, 21, 21),
      ));

    }



  }
}