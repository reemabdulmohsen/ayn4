import 'package:ayn3/blind/Settings/settings.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  @override
  State<TutorialPage> createState() => TutorialPageState();
}

class TutorialPageState extends State<TutorialPage> {
  @override
  Widget build(BuildContext context) {
    return settingsPageState.indexSettings == 0
        ? settingsPage()
        : Container(
            padding: EdgeInsets.only(top: 60, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconButton(

                alignment: Alignment.topRight,
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: (() => setState(() {
                  settingsPageState.indexSettings = 0;
                })),
                  ),
                SizedBox(height: 10,),
                Container(


                  child: const Text(
                    "كيف استخدم التطبيق ؟",
                    textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: "PNU",
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      textAlign: TextAlign.right,
                      "اتبع الخطوات التالية :",
                      style: TextStyle(
                          fontFamily: "PNU",
                          fontWeight: FontWeight.w200,
                          fontSize: 25),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "1- شاركنا رابط التغريدة للصورة التي ترغب في وصفها",
                      style: TextStyle(
                          fontFamily: "PNU",
                          fontWeight: FontWeight.w200,
                          fontSize: 15),
                    ),
                    Text(
                      "2- تلقائياً سيظهر لك وصف الصورة التي شاركتها ، يمكنك إعادة سماع الوصف مره أخرى أو سماع وصف إضافي للصورة من قبل المتطوعين المبصرين",
                      style: TextStyle(
                          fontFamily: "PNU",
                          fontWeight: FontWeight.w200,
                          fontSize: 15),
                    ),
                    Text(
                      "3- يمكنك من قائمة الإعدادات تحديد إعدادات الصوت ",
                      style: TextStyle(
                          fontFamily: "PNU",
                          fontWeight: FontWeight.w200,
                          fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
