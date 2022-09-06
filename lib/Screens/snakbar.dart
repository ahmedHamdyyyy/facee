import 'package:flutter/material.dart';

void snaakbar(BuildContext context,String massige) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.deepOrangeAccent,
      content: Text(massige),
    ),
  );
}