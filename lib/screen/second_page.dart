import 'dart:ui';

import 'package:flutter/material.dart';

class Game_Screen extends StatefulWidget {
  const Game_Screen({Key? key}) : super(key: key);

  @override
  State<Game_Screen> createState() => _Game_ScreenState();
}

class _Game_ScreenState extends State<Game_Screen> {
  List<DrawModel> list = [];
  List img = [
    "assets/images/game1.jpeg",
    "assets/images/game2.jpeg",
    "assets/images/game4.webp",
    "assets/images/game5.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView.builder(
              itemCount: img.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, 'page2',arguments: img[index]);
                  },
                  child: Container(
                    child: Image.asset("${img[index]}"),
                  ),
                );
              },
            ),
            GestureDetector(
              onPanStart: (details) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  Offset point = renderBox.globalToLocal(details.globalPosition);

                  Paint p1 = Paint()
                    ..strokeWidth = 10
                    ..strokeCap = StrokeCap.round
                    ..color = Colors.purple;

                  DrawModel d1= DrawModel(paint: p1,point: point);
                  list.add(d1);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  Offset point = renderBox.globalToLocal(details.globalPosition);

                  Paint p1 = Paint()
                    ..strokeWidth = 10
                    ..strokeCap = StrokeCap.round
                    ..color = Colors.purple;

                  DrawModel d1= DrawModel(paint: p1,point: point);

                  list.add(d1);
                });
              },
              onPanEnd: (details) {
                setState((){
                  list.add(DrawModel(point: null,paint: null));
                });
              },
              child: CustomPaint(
                size: Size.infinite,
                painter: Drawing(list),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class DrawModel {
  Paint? paint;
  Offset? point;

  DrawModel({this.paint, this.point});
}

class Drawing extends CustomPainter {
  Drawing(this.pointlist);

  List<DrawModel> pointlist = [];
  List<Offset> offsetPoints = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointlist.length-1; i++) {
      if (pointlist[i].point != null && pointlist[i + 1].point != null) {
        canvas.drawLine(
            pointlist[i].point!, pointlist[i + 1].point!, pointlist[i].paint!);
      } else if (pointlist[i].point != null && pointlist[i + 1].point == null) {
        offsetPoints.clear();
        offsetPoints.add(pointlist[i].point!);
        offsetPoints.add(
            Offset(pointlist[i].point!.dx + 0.1, pointlist[i].point!.dy + 0.1));
        canvas.drawPoints(PointMode.points, offsetPoints, pointlist[i].paint!);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

