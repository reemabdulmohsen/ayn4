import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ayn3/Volunteer/dashboardV/homev.dart';
import 'package:collection/collection.dart';

class ImageDesc extends StatefulWidget {
  final ImagePath;
  final desc;
  final ImageID;

  Map<String, dynamic> ListOfRates;

  ImageDesc({
    required this.ImagePath,
    required this.desc,
    required this.ImageID,

    required this.ListOfRates
  });

  @override
  State<ImageDesc> createState() => _ImageDescState();
}

class _ImageDescState extends State<ImageDesc> {
  var rating= 0.0;
  @override
  void initState() {
    try {
      rating = widget.ListOfRates[FirebaseAuth.instance.currentUser!.uid];
    } catch (e){
      rating = 0.0;
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 200,

          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Image(

                        image: NetworkImage(

                        (widget.ImagePath),
                      )),
                    ),
                     Text(
                       "الوصف الآلي: "+  widget.desc! ,

                      style: TextStyle(fontFamily: "PNU",),
                    ),
                    RatingBar.builder(
                        initialRating: rating,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemSize: 25,
                        itemBuilder: (context, _) => const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            _updateRATE(rating);
                            this.rating = rating;
                          });
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updateRATE(rating) async {

    // increase number of rated images for the user
    FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"rate_num": homepagev.RateNum + 1});
    homepagev.RateNum = homepagev.RateNum + 1;

    widget.ListOfRates[FirebaseAuth.instance.currentUser!.uid] = rating;
    var values = widget.ListOfRates.values;
    var sum = values.reduce((a, b) => a + b);

    FirebaseFirestore.instance
    .collection("User")
    .doc("AI")
    .collection("desc")
    .doc(widget.ImageID)
    .update({"rate": (sum)/widget.ListOfRates.length, "ListOfRates" : widget.ListOfRates});



  }
}
