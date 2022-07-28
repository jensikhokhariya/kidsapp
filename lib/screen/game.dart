import 'package:flutter/material.dart';

class Game_Page extends StatefulWidget {
  const Game_Page({Key? key}) : super(key: key);

  @override
  State<Game_Page> createState() => _Game_PageState();
}

class _Game_PageState extends State<Game_Page> {
  List img = [
    "assets/images/game1.jpeg",
    "assets/images/game2.jpeg",
    "assets/images/game4.webp",
    "assets/images/game5.jpeg",
  ];
//
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GridView.builder(
          itemCount: img.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Container(
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'page1',arguments: img[index]);
                },
                  child: Image.asset("${img[index]}"),),
            );
          },
        ),
      ),
    );
  }
}
