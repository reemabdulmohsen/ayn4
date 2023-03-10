import 'package:ayn3/contsants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ayn3/Volunteer/dashboardV/homev.dart';

class EditImage extends StatefulWidget {
  String ImagePath;
  String desc;
  String ID;
  EditImage(
      {super.key,
      required this.ImagePath,
      required this.desc,
      required this.ID});

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  TextEditingController _textFieldController = TextEditingController();
  late String valueText = '';
  String codeDialog = "لا يوجد وصف";

  Future<void> EditDescription(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('وصف الصورة الجديد',
                style: TextStyle(fontFamily: "PNU", color: Colors.black)),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(
                  hintText: "ادخل وصف الصورة",
                  hintStyle: TextStyle(fontFamily: "PNU", color: Colors.black)),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(color_purple)),
                child: const Text(
                  'حفظ',
                  style: TextStyle(fontFamily: "PNU", color: Colors.white),
                ),
                onPressed: () {
                  try {
                    if(_textFieldController.text.isEmpty){
                      throw ("Value is empty");
                    }
                    _updateDESC();
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text(
                          'تم حفظ الوصف',
                          style:
                              TextStyle(fontFamily: "PNU", color: Colors.white),
                        ),
                        duration: const Duration(seconds: 6),
                        backgroundColor: Colors.green[600]!,
                      ));
                      codeDialog = valueText;
                      Navigator.pop(context);
                    });
                  } catch (e) {

                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text(
                          'لا يوجد وصف مدخل',
                          style:
                          TextStyle(fontFamily: "PNU", color: Colors.white),
                        ),
                        duration: const Duration(seconds: 6),
                        backgroundColor: Colors.red[900],
                      ));


                    });
                  }
                },
              ),
            ],
          );
        });
  }

  Future<void> deletedecription(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "هل انت متأكد من حذف الوصف؟",
              style: TextStyle(fontFamily: "PNU", color: Colors.black),
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red[900]),
                ),
                onPressed: () {
                  _delete();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'تم حذف الوصف',
                      style: TextStyle(fontFamily: "PNU", color: Colors.white),
                    ),
                    duration: Duration(seconds: 6),
                    backgroundColor: Color.fromARGB(255, 163, 21, 21),
                  ));
                },
                child: const Text(
                  "حذف",
                  style: TextStyle(fontFamily: "PNU", color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "رجوع",
                  style: TextStyle(fontFamily: "PNU", color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    codeDialog = widget.desc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 50,
            ),
            IconButton(
              padding: const EdgeInsets.only(right: 30),
              alignment: Alignment.topRight,
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => {Navigator.pop(context)},
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20.0, top: 20),
              child: Text(
                "مكتبة الصورة الخاصة",
                style: TextStyle(
                    fontFamily: "PNU",
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 350,
                        width: 350,
                        child: Image.network(widget.ImagePath)),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(60)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            codeDialog,
                            style: const TextStyle(
                                fontFamily: "PNU", fontSize: 15),
                          ),
                        ),
                      ),
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
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () {
                          EditDescription(context);
                        },
                        child: const Text(
                          "تعديل الوصف",
                          style:
                              TextStyle(fontFamily: "PNU", color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        gradient: LinearGradient(
                          begin: const Alignment(-0.95, 0.0),
                          end: const Alignment(1.0, 0.0),
                          colors: [
                            const Color.fromARGB(255, 155, 0, 0),
                            Colors.red[900]!
                          ],
                          stops: const [0.0, 1.0],
                        ),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () {
                          deletedecription(context);
                        },
                        child: const Text(
                          "حذف",
                          style:
                              TextStyle(fontFamily: "PNU", color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      )),
    );
  }

  void _updateDESC() async {
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('desc')
        .doc(widget.ID)
        .set({"desc": _textFieldController.text.trim()},
            SetOptions(merge: true));
    homepagev.DescNum = homepagev.DescNum + 1;
  }

  void _delete() async {
    List list = [];

    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .collection('desc')
        .doc(widget.ID)
        .delete();

    await FirebaseFirestore.instance
        .collection("User")
        .doc("AI")
        .collection('desc')
        .doc(widget.ID)
        .get()
        .then((value) {
      list = value['ListOfUser'];
    });
    for (int i = 0; i < list.length; i++) {
      print(list[i]['UserID']);
      print(uid);
      if (list[i]['UserID'] == uid) {
        print(list.remove(list[i]));
      }
    }

    await FirebaseFirestore.instance
        .collection("User")
        .doc('AI')
        .collection('desc')
        .doc(widget.ID)
        .set({"ListOfUser": list}, SetOptions(merge: true));
    homepagev.DescNum = homepagev.DescNum - 1;

    FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"desc_num": homepagev.DescNum});
  }
}


