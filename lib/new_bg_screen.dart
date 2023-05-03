import 'package:flutter/material.dart';

class MyBgScreen extends StatefulWidget {
  MyBgScreen(
      {Key? key,
      required this.height,
      required this.UpperChild,
      required this.LowerChild})
      : super(key: key);
  Widget UpperChild;
  int height;
  Widget LowerChild;

  @override
  State<MyBgScreen> createState() => _MyBgScreenState();
}

class _MyBgScreenState extends State<MyBgScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [UpperUiScreen(), Expanded(child: LowerUiScreen())],
    );
  }

  Widget UpperUiScreen() {
    return Container(
      child: widget.UpperChild,
      height: widget.height.toDouble(),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xff331c50),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))),
    );
  }

  Widget LowerUiScreen() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xff331c50),
        ),
        Container(
          width: double.infinity,
          child: widget.LowerChild,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(80))),
        ),
      ],
    );
  }
}
