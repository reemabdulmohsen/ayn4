import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../contsants.dart';
import 'MainPage.dart';
import 'Profile.dart';

class ChangePassWord extends StatefulWidget {
  @override
  State<ChangePassWord> createState() => ChangePassWordState();
}

class ChangePassWordState extends State<ChangePassWord> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _repasswordController = TextEditingController();
    return MainPageState.indexSettings == 1
        ? Profile()
        : Container(
      padding: EdgeInsets.only(top: 60, right: 20,left: 20),
      child: SingleChildScrollView(
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
                "تغيير كلمة المرور",
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
                "أدخل  كلمة المرور الجديدة",
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
                                obscureText: true,
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "كلمة المرور",
                                  hintStyle: TextStyle(
                                      fontFamily: "PNU", fontSize: 15),
                                )
                            )
                        )
                    )
                ),
                const SizedBox(
                  height: 20,
                ),  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(60)),
                        child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: TextField(
                                obscureText: true,
                                controller: _repasswordController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "تأكيد كلمة المرور",
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
                      if(_repasswordController.text != _passwordController.text){
                        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                          content:  Text(
                            "كلمة المرور غير متطابقة",
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontFamily: "PNU", color: Colors.white),
                          ),
                          duration:const  Duration(seconds: 5),
                          backgroundColor: const Color.fromARGB(255, 163, 21, 21),
                        ));
                      } else {resetPassword(_passwordController.text);}
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
      ),
    );
  }

  Map errors = { "weak-password": "كلمة المرور ضعيفة! كلمة المرور يجب ان تكون اطول من ٦ خانات , ","requires-recent-login": "حصل خطأ.. حاول مجدداً"};
  Future resetPassword(String newPassword) async {
    try{
      final user = await FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user?.updatePassword(newPassword);

      }
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
        content:   Text(
          "تم تحديث كلمة المرور بنجاح! ",
          textAlign: TextAlign.left,
          style: TextStyle(fontFamily: "PNU", color: Colors.white),
        ),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.green,
      ));

    } on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content:  Text(
          errors[e.code],
          textAlign: TextAlign.left,
          style: const TextStyle(fontFamily: "PNU", color: Colors.white),
        ),
        duration:const  Duration(seconds: 5),
        backgroundColor: const Color.fromARGB(255, 163, 21, 21),
      ));

    }



  }
}