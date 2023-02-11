import 'package:ayn3/blind/Settings/settings.dart';
import 'package:ayn3/blind/descPage.dart';
import 'package:flutter/material.dart';

class VoiceSett extends StatefulWidget {
  @override
  State<VoiceSett> createState() => VoiceSettPage();
}

class VoiceSettPage extends State<VoiceSett> {
  double currentValue = 0;
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return settingsPageState.indexSettings == 0
        ? settingsPage()
        : Container(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            alignment: Alignment.topRight,
                            primary: Colors.white,
                            onPrimary: Colors.black,
                            shadowColor: null,
                            side: const BorderSide(
                                color: Colors.white, width: 0)),
                        onPressed: (() => setState(() {
                              settingsPageState.indexSettings = 0;
                            })),
                        child: const Icon(Icons.arrow_back_ios)),
                  ],
                ),
                const Text(
                  "إعدادات قراءة الوصف",
                  style: TextStyle(
                      fontFamily: "PNU",
                      fontWeight: FontWeight.w900,
                      fontSize: 30),
                ),
                const Text(
                  "معدل سرعة الصوت",
                  style: TextStyle(
                      fontFamily: "PNU",
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      child: Icon(Icons.minimize_rounded),
                    ),
                    Slider(

                        value: MyDescPage.volume,
                        onChanged: (newVolume) {
                          setState(() => MyDescPage.volume = newVolume);
                        },
                        min: 0.0,
                        max: 1.0,
                        divisions: 10,

                    ),
                    Container(
                      height: 40,
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
                Divider(
                  thickness: 3,
                  color: Colors.grey,
                ),
                const Text("الصوت",
                    style: TextStyle(
                        fontFamily: "PNU",
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                Column(
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: _value,
                          groupValue: _value,
                          onChanged: (value) {},
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => Colors.lightBlue),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("ذكر",
                            style: TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.bold,
                                fontSize: 20))
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: _value,
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("أنثى",
                            style: TextStyle(
                                fontFamily: "PNU",
                                fontWeight: FontWeight.bold,
                                fontSize: 20))
                      ],
                    )
                  ],
                ),
              ],
            ));
  }
}
