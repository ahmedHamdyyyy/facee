import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class coustoumBotum extends StatelessWidget {
  coustoumBotum({ this.onchanged,this.onTap,required this.text});
  String text;
  VoidCallback? onTap;
  Function(String)? onchanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}