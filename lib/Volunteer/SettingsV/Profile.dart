// ignore_for_file: non_constant_identifier_names


import 'package:ayn3/Volunteer/SettingsV/ChangeEmail.dart';
import 'package:ayn3/contsants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'ChangeName.dart';
import 'ChangePassWord.dart';
import 'MainPage.dart';



// ignore: camel_case_types
class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => ProfilePageState();
}

class ProfilePageState extends State<Profile> {
  List<Widget> page = [];

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: [
          MainPageState.indexSettings == 1
              ? Align(
            child: Container(
              child: ListView(
                padding: const EdgeInsets.only(top: 20, right: 20),
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    alignment: Alignment.topRight,
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: (() => setState(() {
                      MainPageState.indexSettings = 0;
                    })),
                  ),const SizedBox(
                    height: 20,
                  ),
                  const Text("الملف الشخصي ",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "PNU",
                          fontWeight: FontWeight.bold)),

                  SettingsGroup(
                      titleTextStyle:
                      const TextStyle(fontSize: 20, fontFamily: "PNU"),
                      title: "تعديل الملف الشخصي",
                      children: [buildChangeName(),buildChangeEmail(),buildChangePass()]),
                ],
              ),
            ),
          )
              : MainPageState.indexSettings == 4
              ? Scaffold(
              body: ChangeEmail()
          )
              : MainPageState.indexSettings == 5
              ? Scaffold(
              body: ChangeName()
          )
              : MainPageState.indexSettings == 6
              ? Scaffold(
              body:  ChangePassWord()
          )
              : MainPage()
        ],
      );

  }

  Widget buildChangeName() {
    return SimpleSettingsTile(
        titleTextStyle: const TextStyle(fontSize: 15, fontFamily: "PNU",fontWeight: FontWeight.w100),
        title: "تغيير أسم المستخدم",
        leading: const Icon(
          Icons.manage_accounts_rounded,
          color: color_purple,
        ),
        onTap: () {
          setState(() {
            MainPageState.indexSettings = 5;
          });
        });
  }

  Widget buildChangeEmail() {
    return SimpleSettingsTile(
        titleTextStyle: const TextStyle(fontSize: 15, fontFamily: "PNU",fontWeight: FontWeight.w100),
        title: "تغيير البريد الإلكتروني",
        leading: const Icon(Icons.email_rounded, color: color_purple),
        onTap: () {
          setState(() {
            MainPageState.indexSettings = 4;
          });
        });
  }

  Widget buildChangePass() {
    return SimpleSettingsTile(
        titleTextStyle: const TextStyle(fontSize: 15, fontFamily: "PNU", fontWeight: FontWeight.w100),
        title: "تغيير كلمة المرور",
        leading: const Icon(Icons.lock, color: color_purple),
        onTap: () {
          setState(() {
            MainPageState.indexSettings = 6;
          });
        });
  }
}

