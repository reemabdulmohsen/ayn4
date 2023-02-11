

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class GetData{



// to get the image URL from the database using the image id
  static Widget getImageURL(imageID){
    CollectionReference images = FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).collection("desc");

    return FutureBuilder(
        future: images.doc(imageID).get(),
        builder: ((context ,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data =
            snapshot.data!.data() as Map<String,dynamic>;
            return Image.network(imageID,
                fit: BoxFit.contain,

                width: 250,
                height: 200,
                errorBuilder: (context, exception, stackTrack) => Icon(Icons.error));

          }
          return Text('lodaing...');
        }));


  }
  static Widget getImageDesc(imageID){
    CollectionReference images = FirebaseFirestore.instance.collection('images');

    return FutureBuilder(
        future: images.doc(imageID).get(),
        builder: ((context ,snapshot){

          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data =
            snapshot.data!.data() as Map<String,dynamic>;
            return Text(data['desc']);


          }
          return Text('lodaing...');
        }));


  }

  // to get the image URL from the database using the image id
  static Widget getUserId(userID, element){
    CollectionReference images = FirebaseFirestore.instance.collection('images');

    return FutureBuilder(
        future: images.doc(element).collection("desc").doc(userID).get(),
        builder: ((context ,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            print("heeee");
            Map<String, dynamic> data =
            snapshot.data!.data() as Map<String,dynamic>;
            return Text(data['userID']);
          }
          return Text('lodaing...');
        }));


  }

}