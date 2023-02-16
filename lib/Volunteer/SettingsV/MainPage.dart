// ignore_for_file: non_constant_identifier_names


import 'package:ayn3/Volunteer/SettingsV/VolReportPage.dart';
import 'package:ayn3/contsants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'Profile.dart';
import 'VolTutorialPage.dart';



// ignore: camel_case_types
class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  static int indexSettings = 0;
  List<Widget> page = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          indexSettings == 0
              ? Align(
            child: Container(
              child: ListView(
                padding: const EdgeInsets.only(top: 20, right: 20),
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Text("الإعدادات ",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "PNU",
                          fontWeight: FontWeight.bold)),

                  SettingsGroup(
                      titleTextStyle:
                      const TextStyle(fontSize: 20, fontFamily: "PNU"),
                      title: "اعدادات الحساب",
                      children: [BuildProfile()]),
                  SettingsGroup(
                      titleTextStyle: const TextStyle(
                        fontSize: 20,
                        fontFamily: "PNU",
                      ),
                      title: "الدعم الفني",
                      children: [ buildTutorial(),BuildReport()]),
                ],
              ),
            ),
          )
              : indexSettings == 1
              ? Scaffold(
            body: Profile()
          )
              : indexSettings == 2
              ? Scaffold(
            body: VolTutorialPage()
          )
              : indexSettings == 3
              ? Scaffold(
            body:  VolReportPage()
          )
              : Profile()
        ],
      ),
    );
  }

  Widget BuildProfile() {

    return SimpleSettingsTile(
        titleTextStyle: const TextStyle(fontSize: 15, fontFamily: "PNU"),
        title: "الملف الشخصي",
        leading: const Icon(
          Icons.manage_accounts_rounded,
          color: color_purple,
        ),
        onTap: () {
          setState(() {
            indexSettings = 1;
            print(indexSettings);
          });
        });

  }

  Widget BuildReport() {
    return SimpleSettingsTile(
        titleTextStyle: const TextStyle(fontSize: 15, fontFamily: "PNU"),
        title: " شاركنا رأيك",
        leading: const Icon(Icons.email_rounded, color: color_purple),
        onTap: () {
          setState(() {
            indexSettings = 3;
          });
        });
  }

  Widget buildTutorial() {
    return SimpleSettingsTile(
        titleTextStyle: const TextStyle(fontSize: 15, fontFamily: "PNU"),
        title: " كيف استخدم التطبيق؟",
        leading: const Icon(
          Icons.help_rounded,
          color: color_purple,
        ),
        onTap: () {
          setState(() {
            indexSettings = 2;
          });
        });
  }}
