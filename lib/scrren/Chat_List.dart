import 'package:firebase/model/message.dart';
import 'package:flutter/material.dart';

class chatBuble extends StatelessWidget {
  const chatBuble({
    Key? key,
    required this.messag,

  }) : super(key: key);
    final Message messag;
  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        //alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: EdgeInsets.only(left: 16, top: 20, bottom: 20, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Color(0xff2B475E),
        ),
        child: Text(
          messag.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
