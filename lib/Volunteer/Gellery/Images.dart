// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors

import 'package:ayn3/Volunteer/AddImages/addimage.dart';
import 'package:ayn3/Volunteer/GetData.dart';
import 'package:ayn3/contsants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'EditImage.dart';

class ImageDesc extends StatefulWidget {
  final ImagePath;
  final desc;
  final ImageID;

  const ImageDesc({
    required this.ImagePath,
    required this.desc,
    required this.ImageID
  });

  @override
  State<ImageDesc> createState() => _ImageDescState();
}

class _ImageDescState extends State<ImageDesc> {
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image(

                              image: NetworkImage(

                                (widget.ImagePath),
                              )),

                        ),
                      ),

                    ],
                  ),
                ),
                TextButton(

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
                            builder: (context) => EditImage(ImagePath: widget.ImagePath, desc: widget.desc, ID: widget.ImageID,)));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
