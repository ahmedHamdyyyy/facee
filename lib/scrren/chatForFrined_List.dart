import 'package:flutter/material.dart';

class chatForFrind_List extends StatelessWidget {
  const chatForFrind_List({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        //alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: EdgeInsets.only(left: 16, top: 20, bottom: 20, right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(0),
          ),
          color: Colors.black,
        ),
        child: Text(
          " Ahmed hamdy mohamed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
