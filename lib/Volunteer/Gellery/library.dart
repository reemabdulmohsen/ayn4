// ignore_for_file: camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'Images.dart';

class libraryPage extends StatefulWidget {
  const libraryPage({super.key});

  @override
  State<libraryPage> createState() => _libraryPagState();
}

class _libraryPagState extends State<libraryPage> {


  Future getImages() async {
    final userid =  FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('User')
        .doc(userid)
        .collection("desc").get();
    return qn.docs;





  }

  @override
  Widget build(BuildContext context) {
    print("hellooooo");
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
                    Text("مكتبة الصور الخاصة",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "PNU",
                            fontWeight: FontWeight.bold))
                  ]),
            )),
        SizedBox(
            height: 560,
            child: FutureBuilder(
                future: getImages(),
                builder: (context , snapshot ){
                  if(snapshot.hasData){
                    List data = snapshot.data as List;
                    return ListView.builder(
                        itemCount: data.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ImageDesc(
                            ImageID: data[index]['id'],
                            ImagePath: data[index]['link'],
                              desc: data[index]['desc'],

                          );
                        });
                  } else {
                    return Center(
                      child: Lottie.network(
                          "https://assets7.lottiefiles.com/packages/lf20_rwq6ciql.json"),
                    );
                  }
                }
            )),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
