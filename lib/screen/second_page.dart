import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  Color c1 = Colors.blue;

  @override
  Widget build(BuildContext context) {
    String g1= ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: Image.asset("$g1"),
            ),
            GestureDetector(
              onPanStart: (details) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  Offset point =
                  renderBox.globalToLocal(details.globalPosition);

                  Paint p1 = Paint()
                    ..strokeWidth = 10
                    ..strokeCap = StrokeCap.round
                    ..color = c1;

                  DrawModel d1 = DrawModel(paint: p1, point: point);
                  list.add(d1);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  Offset point =
                  renderBox.globalToLocal(details.globalPosition);

                  Paint p1 = Paint()
                    ..strokeWidth = 10
                    ..strokeCap = StrokeCap.round
                    ..color = c1;

                  DrawModel d1 = DrawModel(paint: p1, point: point);

                  list.add(d1);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  list.add(DrawModel(point: null, paint: null));
                });
              },
              child: CustomPaint(
                size: Size.infinite,
                painter: Drawing(list),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 5,
                  width: double.infinity,
                  color: Colors.black,
                ),
                Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.black12,
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 70,
                        color: Colors.pink.shade300,
                        child: Icon(
                          Icons.settings_backup_restore,
                          size: 50,
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 1,
                        color: Colors.white70,
                      ),
                      Container(
                        height: 100,
                        width: 70,
                        color: Colors.pink.shade400,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.brush_outlined,
                            size: 50,
                          ),
                        ),
                      ),
                      Container(
                          height: 100,
                          width: 70,
                          color: Colors.pink.shade400,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.format_color_fill,
                              size: 50,
                            ),
                          )),
                      Container(
                          height: 100,
                          width: 70,
                          color: Colors.pink.shade400,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.home_filled,
                              size: 50,
                            ),
                          )),
                      Container(
                        height: 100,
                        width: 1,
                        color: Colors.white70,
                      ),
                      Container(
                          height: 100,
                          width: 78,
                          color: Colors.pink.shade300,
                          child: IconButton(
                            onPressed: () {
                              bgColor();
                            },
                            icon: Icon(
                              Icons.palette_outlined,
                              size: 50,
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void bgColor() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              ColorPicker(
                  pickerColor: c1,
                  onColorChanged: (color) {
                    setState(() {
                      c1 = color;
                    });
                  })
            ],
          );
        });
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
    for (int i = 0; i < pointlist.length - 1; i++) {
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
