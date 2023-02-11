// ignore_for_file: non_constant_identifier_names

import 'package:ayn3/Volunteer/AddImages/addimage.dart';
import 'package:ayn3/contsants.dart';
import 'package:ayn3/firebase_storge_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:ayn3/Volunteer/GetData.dart';
class AddPage extends StatefulWidget {
  final ImagePath;
  final id;

  AddPage({
    required this.ImagePath,
    required this.id,
  });

  @override
  State<AddPage> createState() => _AddPageState();
}


// the image item in the add description page
class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 200,

          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child:  Image(
                          image: NetworkImage(

                            (widget.ImagePath),
                          )),
                    ),
                    Container(
                      child: TextButton(
                        child: const Text(
                          "عرض",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: "PNU",
                              fontWeight: FontWeight.w100,
                              color: color_DarkGray),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddImage(link: widget.ImagePath, id: widget.id)));
                         },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
