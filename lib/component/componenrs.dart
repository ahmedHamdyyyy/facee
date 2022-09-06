import 'package:firebase/local/cach_helper.dart';
import 'package:firebase/shoichialAPP/SoicialLogin/blokLoginSoictiall/SocialLoginScreen%20.dart';
import 'package:firebase/shoichialAPP/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigatorTo(context, Widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),
);
void navigatorToReplasment(context, Widget) =>Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => Widget,
  ),
);
void ShowToast({ required String text,required ToustStute stute })=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: ChoseToustColor(stute),
    textColor: Colors.white,
    fontSize: 16.0
);
enum ToustStute{SUCCESS,ERROR,WORNNING}
Color ChoseToustColor(ToustStute stute)
{
  Color color;
  switch(stute)
  {
    case ToustStute.SUCCESS:
      color= Colors.green;
      break ;
    case ToustStute.ERROR:
      color= Colors.red;
      break ;
    case ToustStute.WORNNING:
      color= Colors.amber;
      break ;

  }
  return color;

}

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required validate,
  onSubmit,
  required String? label,
  required IconData? prefix,
  Function? suffixPressed,
  bool isPassword = false,
  IconData? suffix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: const OutlineInputBorder(),
      ),
    );
Widget defaultButton({
  double height = 40,
  double width = double.infinity,
  Color background = defaultColor,
  double radius = 5.0,
  bool isUpperCase = true,
  required Function function,
  required String? text,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        // onPressed: function,
        child: Text(
          isUpperCase ? text!.toUpperCase() : text!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

void signOut(context) {
  CachHealper.removeData(
    key: 'uId',
  ).then((value) {
    if (value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SocialLoginScreen(),
        ),
            (Route<dynamic> route) => false,
      );
    }
  });
}