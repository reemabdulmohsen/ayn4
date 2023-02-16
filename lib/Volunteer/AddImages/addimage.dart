import 'package:ayn3/contsants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ayn3/Volunteer/dashboardV/homev.dart';


class AddImage extends StatefulWidget {
  final link;
  final id;
  const AddImage({super.key , required this.link, required this.id});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  final TextEditingController _desc = TextEditingController();
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
                "الصور المطلوب وصفها",
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40))
              ),
                      margin: const EdgeInsets.only(bottom: 30),
                      height: 350,
                      width: 350,
                      child: Image.network(widget.link)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60)),
                      child:  Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextField(
                          controller: _desc,
                            decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "ادخل وصف الصورة",
                          hintStyle: TextStyle(fontFamily: "PNU", fontSize: 15),
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),


                  // button
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
                      onPressed: () => addDescriptioninDB(_desc.text.trim(), widget.link),
                      child: const Text(
                        "اضافة الوصف",
                        style:
                            TextStyle(fontFamily: "PNU", color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  addDescriptioninDB(String desc, String link) async {

    List listOfuser = [];

    try {

      if((desc == "" )| (desc == null)){
        throw CustomException('لا يوجد وصف ');
      }

      final userid = await FirebaseAuth.instance.currentUser!.uid;
      //add the desc to the user
      await FirebaseFirestore.instance.collection('User').doc(
          userid).collection("desc").doc(widget.id).set(
          {"desc": desc, "link": link , "id": widget.id });


      //get the list
      await FirebaseFirestore.instance.collection('User').doc(
          "AI").collection("desc").doc(widget.id).get().then((element){

        listOfuser =  element["ListOfUser"];
      });

      // update the list
      listOfuser.add({"UserID" :userid , "UserDesc": desc});

      // update the list in firebase
      await FirebaseFirestore.instance.collection('User').doc(
          "AI").collection("desc").doc(widget.id).set(
          {"ListOfUser" : listOfuser },SetOptions(merge: true),);
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "تم اضافة الوصف بنجاح!",
          textAlign: TextAlign.left,
          style: TextStyle(fontFamily: "PNU", color: Colors.white),
        ),
        duration: Duration(seconds: 6),
        backgroundColor: Colors.green,
      ));
      _updataDescNum();

    }  on CustomException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.cause,
          textAlign: TextAlign.left,
          style: const TextStyle(fontFamily: "PNU", color: Colors.white),
        ),
        duration: const Duration(seconds: 6),
        backgroundColor: const Color.fromARGB(255, 163, 21, 21),
      ));
    }



  }
  void _updataDescNum() async {
    FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"desc_num": homepagev.DescNum + 1});
    homepagev.DescNum = homepagev.DescNum + 1;
  }

}
class CustomException implements Exception {
  String cause;
  CustomException(this.cause);
}

