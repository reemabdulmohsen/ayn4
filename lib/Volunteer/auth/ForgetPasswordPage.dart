import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../contsants.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(children: [
          IconButton(
            alignment: Alignment.topRight,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => {Navigator.pop(context)},
          ),
          Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'كلمة مرور جديدة',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "PNU",
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 20,
          ),
          Text("ادخل البريد الالكتروني",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "PNU",
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: const BorderRadius.all(Radius.circular(30.0))),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: "البريد الالكتروني",
                hintStyle: TextStyle(
                    fontFamily: "PNU",
                    fontWeight: FontWeight.w300,
                    fontSize: 15),
              ),
            ),
          ),
          SizedBox(
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
              onPressed: forgetpass,
              style: ButtonStyle(
                shadowColor: MaterialStateProperty.all(Colors.transparent),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: const Text(
                "اعادة ضبط كلمة المرور",
                style: TextStyle(fontFamily: "PNU", color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Map errors = {"user-not-found": "البريد الإلكتروني غير مسجل" , "invalid-email": "البريد الإلكتروني غير صحيح" , "unknown": "حصل خطأ.. حاول مجدداً"};
  Future forgetpass() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'تم ارسال ايميل لتفعيل كلمة السر',
          style: TextStyle(fontFamily: "PNU", color: Colors.white),
        ),
        duration: Duration(seconds: 6),
        backgroundColor: Colors.green,
      ));
    } on FirebaseAuthException catch (e) {


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          errors[e.code],
          textAlign: TextAlign.left,
          style: TextStyle(fontFamily: "PNU", color: Colors.white),
        ),
        duration: Duration(seconds: 6),
        backgroundColor: Color.fromARGB(255, 163, 21, 21),
      ));
    }
  }
}
