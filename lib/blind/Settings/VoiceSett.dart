import 'package:ayn3/blind/Settings/settings.dart';
import 'package:ayn3/blind/descPage.dart';
import 'package:ayn3/contsants.dart';
import 'package:flutter/material.dart';

class VoiceSett extends StatefulWidget {
  static sonudSpeed? speed = sonudSpeed.slow;
  @override
  State<VoiceSett> createState() => VoiceSettPage();
}

enum sonudSpeed { fast , slow, medium }



class VoiceSettPage extends State<VoiceSett> {
  double currentValue = 0;


  @override
  Widget build(BuildContext context) {
    return settingsPageState.indexSettings == 0
        ? settingsPage()
        : Container(
            padding: EdgeInsets.only(top: 60, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  alignment: Alignment.topRight,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: (() => setState(() {
                        settingsPageState.indexSettings = 0;
                      })),
                ),
                const Text(
                  "إعدادات قراءة الوصف",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PNU",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "معدل سرعة الصوت",
                  style: TextStyle(
                      fontFamily: "PNU",
                      fontWeight: FontWeight.normal,
                      fontSize: 20),
                ),
                Column(
                  children: [
                    ListTile(
                      selectedTileColor: color_purple,

                      title: const Text('سريع',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: "PNU",
                      )),
                      leading: Radio(
                          fillColor: MaterialStateColor.resolveWith((states) => color_purple),
                          focusColor: MaterialStateColor.resolveWith((states) =>  color_purple),
                          value: sonudSpeed.fast,
                          groupValue:   VoiceSett.speed,
                          onChanged: (value) {
                            setState(() {
                              VoiceSett.speed = value;
                            });
                          }),),

                    ListTile(
                      selectedTileColor: color_purple,
                      focusColor: color_purple,
                      title: const Text('متوسط',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: "PNU",
                      ),),
                      leading: Radio(
                          fillColor: MaterialStateColor.resolveWith((states) => color_purple),
                          focusColor: MaterialStateColor.resolveWith((states) =>  color_purple),
                          value: sonudSpeed.medium,
                          groupValue: VoiceSett.speed,
                          onChanged: (value) {

                            setState(() {
                             VoiceSett.speed = value;
                            });
                          }),
                    ),
                    ListTile(
                      selectedTileColor: color_purple,
                      focusColor: color_purple,
                      title: const Text('بطيء',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        fontFamily: "PNU",
                      ),),
                      leading: Radio(
                          fillColor: MaterialStateColor.resolveWith((states) => color_purple),
                          focusColor: MaterialStateColor.resolveWith((states) =>  color_purple),
                          value: sonudSpeed.slow,
                          groupValue:   VoiceSett.speed,
                          onChanged: (value) {

                            setState(() {
                              VoiceSett.speed = value;
                            });
                          }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

              ],
            ));
  }
}
