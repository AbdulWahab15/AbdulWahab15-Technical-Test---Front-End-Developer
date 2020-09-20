import 'package:flutter/material.dart';

class Ui{
  Color skyblue, darkgreen, purple;

  Ui(){
    skyblue=Color(0xff50C4CC);
    darkgreen=Color(0xff2B4655);
    purple=Color(0xff6200EE);
  }



}

class Handler {
  String Url;

  Handler(String controller) {
    Url = 'https://naya-oraan.herokuapp.com/$controller';
  }

  String getUrl() {
    return Url;
  }
}
