import 'package:ayn3/blind/Settings/VoiceSett.dart';
import 'package:ayn3/blind/home.dart';
import 'package:ayn3/contsants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DescPage extends StatefulWidget {
  //list contains all the links of the images in the tweet
  List links;
  // number of images in the tweet
  int numOfImage = 0;
  // variable contains the AI description
  static String desc = "";
  DescPage({super.key, required this.links, required this.numOfImage});

  @override
  State<DescPage> createState() => MyDescPage();
}

// TTS states
enum ttsState { playing, stopped }

class MyDescPage extends State<DescPage> {
  // changing the speed value from enums to double
  double SpeedValue() {
    if (VoiceSett.speed == sonudSpeed.slow) {
      return 0.1;
    }
    if (VoiceSett.speed == sonudSpeed.medium) {
      return 0.5;
    } else
      return 1.0;
  }

  //list will contain all the volunteers descriptions of a specific image
  List ListOfDesc = [];

  //Text to speech object
  static late FlutterTts flutterTts;

  //Initial value is stoped
  ttsState State = ttsState.stopped;

  @override
  initState() {
    super.initState();
    initTTS();
    Play(); // starting the description audio
  }

  initTTS() async {
    print("initTTS");
    flutterTts = FlutterTts();

    await flutterTts.awaitSpeakCompletion(true);
    flutterTts.setStartHandler(() {
      setState(() {
        State = ttsState.playing;
        print("start");
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {

        State = ttsState.stopped;
        print("stopped");
      });
    });

    flutterTts.setErrorHandler((message) {
      setState(() {
        State = ttsState.stopped;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.numOfImage = 0;
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //return button
            IconButton(
              alignment: Alignment.topRight,
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => {
                MyHomePageState.NumOfImage = 0,
                Navigator.of(context)
                    .pop()
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

            // the box description
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
            // "replay" button
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
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
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
            // "more description" button
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
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
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
      ),
    ));
  }

  // function to start the audio
  Future Play() async {
    if (State == ttsState.stopped) {
      await flutterTts.setVolume(1);
      await flutterTts.setSpeechRate(SpeedValue());
      await flutterTts.setPitch(1);
      if ((DescPage.desc != null) | DescPage.desc.isNotEmpty) {
        await flutterTts.speak(DescPage.desc);
      }
    }
  }

  // function to fet the extra descriptions
  ExtraDesc() {

    return widget.numOfImage > 1
        ? // in case the tweet has more the one image
            showDialog(
            context: context,
            builder: (context) {

              // ask the user which image wants more description for
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
                                    // add all the volunteers description in "desc" variable
                                    setState(() {
                                      String ans = "";
                                      for (int i = 0;
                                          i < ListOfDesc.length;
                                          i++) {
                                        ans = ans + "وصف رقم ${i + 1} : ";
                                        ans = ans + ListOfDesc[i]["UserDesc"];
                                        ans = ans + " , ";
                                      }
                                      if(ListOfDesc.isEmpty){
                                        DescPage.desc = "لا يوجد وصف إضافي";
                                      }
                                      DescPage.desc = ans;
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
            })
        : widget.numOfImage == 1?
            // in case the tweet has one description
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
                  ListOfDesc.add(element);
                });

                try {
                  setState(() {
                    String ans = "";
                    for (int i = 0; i < ListOfDesc.length; i++) {
                      ans = ans + "وصف رقم ${i + 1} : ";
                      ans = ans + ListOfDesc[i]["UserDesc"];
                      ans = ans + " , ";
                    }
                    DescPage.desc = ans;
                  });
                } catch (e) {
                  setState(() {
                    DescPage.desc = "لا يوجد وصف إضافي";
                  });
                }
              });
            });
          }) :  setState(() {
      DescPage.desc = "لا يوجد وصف إضافي";
    });
  }
}
