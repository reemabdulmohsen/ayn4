import 'package:ayn3/Volunteer/auth/Signup.dart';
import 'package:ayn3/contsants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ForgetPasswordPage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[color_blue, color_purple],
  ).createShader(const Rect.fromLTWH(0.10, 0.30, 50.0, 70.0));
  final FormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                      'تسجيل الدخول ',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "PNU",
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key: FormKey,
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
                        SizedBox(
                          height: 10,
                        ),
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
                            filled: true,
                            fillColor: Colors.blueGrey[50],
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "كلمة المرور",
                            hintStyle: const TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.w300,
                                fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
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
                    onPressed: loginFun,
                    style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: const Text(
                      "تسجيل دخول",
                      style: TextStyle(fontFamily: "PNU", color: Colors.white),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ForgetPasswordPage();
                      },
                    ));
                    //forgot password screen
                  },
                  child: Text(
                    'نسيت كلمة المرور ',
                    style: TextStyle(
                      fontSize: 15,
                      foreground: Paint()..shader = linearGradient,
                      fontFamily: "PNU",
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(
                  height: 280,
                ),
                Column(
                  children: [
                    const Text(
                      'ليس لديك حساب ؟',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "PNU", fontWeight: FontWeight.w100),
                    ),
                    TextButton(
                      child: Text(
                        'حساب جديد',
                        style: TextStyle(
                            fontFamily: "PNU",
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                    )
                  ],
                ),
              ],
            )));
  }
  Map errors = {"user-not-found": "البريد الإلكتروني غير مسجل" , "invalid-email": "كلمة المرور او البريد الإلكتروني غير صحيحة" , "wrong-password": "كلمة المرور او البريد الإلكتروني غير صحيحة"};
  Future loginFun() async {
    if (FormKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _nameController.text.trim(),
            password: _passwordController.text.trim());

        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUp()),
          );
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content:  Text(
            errors[e.code],
            textAlign: TextAlign.left,
            style: TextStyle(fontFamily: "PNU", color: Colors.white),
          ),
          duration: Duration(seconds: 5),
          backgroundColor: Color.fromARGB(255, 163, 21, 21),
        ));
      }
    }
  }

}
