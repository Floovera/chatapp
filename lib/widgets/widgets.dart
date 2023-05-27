import 'package:flutter/material.dart';


const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF69D7D7),width: 2),
  ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF909EE7),width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFEA3B79),width: 2),
    )
);

void nextScreen(context,page){
  Navigator.push(context,MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context,page){
  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => page));
}
