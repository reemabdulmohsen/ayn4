// ignore_for_file: use_build_context_synchronously

import 'package:ayn3/contsants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import '../dashboardV/navbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final _form = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                IconButton(
                  alignment: Alignment.topRight,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => {Navigator.pop(context)},
                ),
                Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'تسجيل حساب جديد ',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "PNU",
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Form(
                    key: _form,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        TextFormField(

                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return '*مطلوب';
                            }
                            return null;
                          },


                          controller: _nameController,
                          decoration: InputDecoration(

                            errorStyle: const TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.w300,
                                fontSize: 11),
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "اسم المستخدم",
                            hintStyle: const TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.w300,
                                fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return '*مطلوب';
                            }
                            return null;
                          },
                          controller: _emailController,
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.w300,
                                fontSize: 11),
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "البريد الالكتروني",
                            hintStyle: const TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.w300,
                                fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //
                        TextFormField(
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return '*مطلوب';
                            }
                            return null;
                          },
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.w300,
                                fontSize: 11),
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                            hintText: "كلمة المرور",
                            hintStyle: const TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.w300,
                                fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // re-enter password
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '*مطلوب';
                            } else if (value != _passwordController.text) {
                              return 'كلمة المرور غير مطابقة';
                            } else
                              return null;
                          },
                          obscureText: true,
                          controller: _repasswordController,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.w300,
                                fontSize: 11),
                            errorStyle: const TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.w300,
                                fontSize: 11),
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                            hintText: "تأكيد كلمة المرور",
                            hintStyle: const TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.w300,
                                fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // singup button
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
                            style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            onPressed: SignUpFun,
                            child: const Text(
                              "تسجيل دخول",
                              style: TextStyle(
                                  fontFamily: "PNU", color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            )));
  }
  Map errors = {"email-already-in-use": "البريد الإلكتروني مسجل من قبل" , "invalid-email": "البريد الإلكتروني غير صحيح" , "weak-password": "كلمة المرور ضعيفة! كلمة المرور يجب ان تكون اطول من ٦ خانات", "operation-not-allowed" : " حصل خطأ.. حاول مجدداً"};

  // ignore: non_constant_identifier_names
  Future SignUpFun() async {
    if (_form.currentState!.validate()) {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      try {
        var _authenticatedUser = await _auth
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim())
            .then((value) => FirebaseFirestore.instance
                    .collection("User")
                    .doc(value.user!.uid)
                    .set({
                  "name": _nameController.text.trim(),
                  "desc_num": 0,
                  "rate_num": 0
                }));
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "تم تسجيلك بنجاح! الرجاء تفعيل بريدك الالكتروني",
            textAlign: TextAlign.left,
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
            style: const TextStyle(fontFamily: "PNU", color: Colors.white),
          ),
          duration: const Duration(seconds: 6),
          backgroundColor: const Color.fromARGB(255, 163, 21, 21),
        ));
      }
    }
  }
}
