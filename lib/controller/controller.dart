import 'package:flutter/material.dart';

import '../Volunteer/AddImages/requestedImages.dart';
import '../Volunteer/Gellery/library.dart';
import '../Volunteer/Rate/RatePage.dart';
import '../Volunteer/dashboardV/homev.dart';

class Controller with ChangeNotifier{
  int index = 0;
  bool isLoading =false;
  List pages = const [
    homepagev(), //0
    libraryPage(), //1
    homepagev(), //2
    RequestedImage(), //3
    RatePage(), //4
  ];

  void changeIndex(value){
    index = value;
    notifyListeners();

  }
  void changeLoading (bool val){
    isLoading = val;
    notifyListeners();
  }
}