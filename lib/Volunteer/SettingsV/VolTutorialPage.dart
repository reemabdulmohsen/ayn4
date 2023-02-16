import 'package:flutter/material.dart';
import 'MainPage.dart';

class VolTutorialPage extends StatefulWidget {
  @override
  State<VolTutorialPage> createState() => VolTutorialPageState();
}

class VolTutorialPageState extends State<VolTutorialPage> {
  @override
  Widget build(BuildContext context) {

    return MainPageState.indexSettings == 0
        ? MainPage()
        : Container(
      padding: EdgeInsets.only(top: 60, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(

            alignment: Alignment.topRight,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: (() => setState(() {
              MainPageState.indexSettings = 0;
            })),
          ),
          SizedBox(height: 10,),
          Container(


            child: const Text(
                "كيف استخدم التطبيق ؟",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: "PNU",
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                textAlign: TextAlign.right,
                "اتبع الخطوات التالية :",
                style: TextStyle(
                    fontFamily: "PNU",
                    fontWeight: FontWeight.w200,
                    fontSize: 25),
              ),
              SizedBox(height: 20,),
              Text(
                "1- لوصف صور جديدة قم بالضغط على زر الصور المطلوب وصفها اضغط على الصورة التي ترغب بوصفها، اكتب وصفك للصورة، ثم اضغط على زر إضافة وصف واحفظه",
                style: TextStyle(
                    fontFamily: "PNU",
                    fontWeight: FontWeight.w200,
                    fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "2- لتقييم الوصف الآلي للصور قم بالضغط على زر التقييم الآلي ستظهر لك جميع الصور ثم قم بتقييم الوصف",
                style: TextStyle(
                    fontFamily: "PNU",
                    fontWeight: FontWeight.w200,
                    fontSize: 15),
              ),   SizedBox(
                height: 10,
              ),
              Text(
                "3- لرؤية جميع الصور التي قمت بوصفها سابقًا وتعديل او حذف وصفك قم بالضغط على زر مكتبة الصور الخاصة ",
                style: TextStyle(
                    fontFamily: "PNU",
                    fontWeight: FontWeight.w200,
                    fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
