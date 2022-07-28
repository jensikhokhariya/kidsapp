import 'package:flutter/material.dart';
import 'package:kidsapp/screen/game.dart';
import 'package:kidsapp/screen/second_page.dart';
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=>Game_Page(),
        'page1':(context)=>Game_Screen(),
      },
    ),
  );
}
