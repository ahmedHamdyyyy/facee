import 'package:flutter/material.dart';

class TextFormFiled extends StatelessWidget {
  TextFormFiled({ this.hint,
    required this.TextInputTyp,
     required this.IconPrefex,
    this.onchanged,

  }) ;
  String? hint;
  Function(String)? onchanged;
  IconData IconPrefex;

  TextInputType  TextInputTyp;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:(data)
      {
        if(data!.isEmpty)
        {
          return"المكان لا يمكن ان يكون فارغ ياعم ";
        }
        else return null;
      },
      onChanged:onchanged ,
      keyboardType: TextInputTyp,
      decoration: InputDecoration(
        prefixIcon:  Icon(IconPrefex),
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}