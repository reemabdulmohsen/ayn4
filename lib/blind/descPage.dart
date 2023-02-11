import 'package:ayn3/blind/home.dart';
import 'package:ayn3/contsants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DescPage extends StatefulWidget {
  List links;
  int numOfImage;
  DescPage({super.key, required this.links, required this.numOfImage});
  static String desc = "";

  @override
  State<DescPage> createState() => MyDescPage();
}

// TTS states
enum ttsState { playing, stopped }

class MyDescPage extends State<DescPage> {
  static double volume = 0.5;
  static double pitch = 0.1;
  static double rate = 0.5;
  List ListOfDesc = [];
  bool isFinish = false;

  late FlutterTts _flutterTts;
  ttsState _State = ttsState.stopped;

  @override
  initState() {
    super.initState();
    initTTS();
  }

  initTTS() async {
    _flutterTts = FlutterTts();

    await _flutterTts.awaitSpeakCompletion(true);
    _flutterTts.setStartHandler(() {
      setState(() {
        print("play");
        _State = ttsState.playing;
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        print("complete");
        _State = ttsState.stopped;
      });
    });

    _flutterTts.setErrorHandler((message) {
      setState(() {
        print("Error");
        _State = ttsState.stopped;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.numOfImage = 0;
    _flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30),
      child: ListView(
        children: [
          IconButton(
            alignment: Alignment.topRight,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyHomePage()))
            },
          ),
          Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'وصف الصورة:',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "PNU",
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                DescPage.desc,
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "PNU",
                    fontWeight: FontWeight.w100),
              )),
          const SizedBox(
            height: 40,
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
              style: ButtonStyle(
                shadowColor: MaterialStateProperty.all(Colors.transparent),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: Play,
              child: const Text(
                "تكرار",
                style: TextStyle(fontFamily: "PNU", color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
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
              style: ButtonStyle(
                shadowColor: MaterialStateProperty.all(Colors.transparent),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: ExtraDesc,
              child: const Text(
                "وصف إضافي",
                style: TextStyle(fontFamily: "PNU", color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future Play() async {
    if (_State == ttsState.stopped) {
      await _flutterTts.setVolume(volume);
      await _flutterTts.setSpeechRate(rate);
      await _flutterTts.setPitch(1.0);
      if ((DescPage.desc != null) | DescPage.desc.isNotEmpty) {
        await _flutterTts.speak(DescPage.desc);
      }
    }
  }

  ExtraDesc() {
    return widget.numOfImage > 1 ? showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text(
                "ماهي الصورة التي تريد وصف إضافي لها؟",
                style: TextStyle(fontFamily: "PNU", color: Colors.black),
              ),
              content: Container(
                  height: 200,
                  width: 300,
                  child: ListView.builder(
                    itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          ListOfDesc.clear();
                          await FirebaseFirestore.instance
                              .collection("User")
                              .doc("AI")
                              .collection("desc")
                              .doc(widget.links[index])
                              .get()
                              .then((val) {
                            setState(() {
                              val.data()?['ListOfUser'].forEach((element) {
                                ListOfDesc.add(element['UserDesc']);
                              });
                              try {
                                setState(() {
                                  DescPage.desc = ListOfDesc[0];
                                });
                              } catch (e) {
                                setState(() {
                                  DescPage.desc = "لا يوجد وصف إضافي";
                                });
                              }
                            });
                          });
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),

                          child: Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              gradient: const LinearGradient(
                                begin: Alignment(-0.95, 0.0),
                                end: Alignment(1.0, 0.0),
                                colors: [color_blue, color_purple],
                                stops: [0.0, 1.0],
                              ),
                            ),

                              child: Text(
                                textAlign: TextAlign.center,
                                "صورة رقم ${index + 1}",
                                style: const TextStyle(

                                    fontFamily: "PNU",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        )),
                    itemCount: widget.numOfImage,
                  )));
        }) :

    setState(() async {
      ListOfDesc.clear();
      await FirebaseFirestore.instance
          .collection("User")
          .doc("AI")
          .collection("desc")
          .doc(widget.links[0])
          .get()
          .then((val) {
        setState(() {
          val.data()?['ListOfUser'].forEach((element) {
            ListOfDesc.add(element['UserDesc']);
          });
          try {
            setState(() {
              DescPage.desc = ListOfDesc[0];
            });
          } catch (e) {
            setState(() {
              DescPage.desc = "لا يوجد وصف إضافي";
            });
          }
        });
      });
      DescPage.desc = ListOfDesc[0];
    });
  }
}
