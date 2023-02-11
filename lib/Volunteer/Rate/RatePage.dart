// ignore_for_file: camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ImageBox.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});

  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {


  Future getImages() async {
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('User')
        .doc('AI')
        .collection("desc").get();
    return qn.docs;}


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
                    Text("تقييم الوصف الآلي",
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
                            ListOfRates: data[index]['ListOfRates'] ,
                            ImageID: data[index]['id'],
                            ImagePath: data[index]['link'],
                            desc: data[index]['desc'],

                          );
                        });
                  } else {
                    return CircularProgressIndicator();
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
