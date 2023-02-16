// ignore_for_file: camel_case_types
import 'package:ayn3/firebase_storge_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Gellery/Images.dart';
import 'Add.dart';

class RequestedImage extends StatefulWidget {
  const RequestedImage({super.key});

  @override
  State<RequestedImage> createState() => _RequestedImageState();
}

class _RequestedImageState extends State<RequestedImage> {
  List imagesID = [];
  @override
  void initState() {
    getImages();
    super.initState();
  }

  Future getImages() async {
    await FirebaseFirestore.instance
        .collection('User')
        .doc('AI')
        .collection("desc")
        .get()
        .then((value) {
          value.docs.forEach((element) {
        if(element.data()['ListOfUser'].isEmpty){

          setState(() {
            imagesID.add(element);

          });

        }else {
          element['ListOfUser'].forEach((val) {
            if (val['UserID'].contains(FirebaseAuth.instance.currentUser!.uid) && element.data()['ListOfUser'].isNotEmpty) {
              return;
            } else {
              setState(() {
                imagesID.add(element);
              });
            }
          });
        }


      });

      print(imagesID);
    });

// await FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection("desc").get().then(
//             (SnapShot) => SnapShot.docs.forEach(
//                     (doc) {
//                       imagesID.add(doc.reference.id);
//                       print(doc.reference.id);
//                     }
//
//             ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 60,
        ),
        SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Text("الصور المطلوب وصفها",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "PNU",
                            fontWeight: FontWeight.bold))
                  ]),
            )),
        SizedBox(
            height: 560,
            child: ListView.builder(
                itemCount: imagesID.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  print(index);
                  return AddPage(
                    ImagePath: imagesID[index]['link'],
                    id: imagesID[index]['id'],
                  );
                })),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
