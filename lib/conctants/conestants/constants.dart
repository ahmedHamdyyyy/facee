import 'package:firebase/component/componenrs.dart';
import 'package:firebase/local/cach_helper.dart';
import 'package:firebase/shoichialAPP/SoicialLogin/blokLoginSoictiall/SocialLoginScreen%20.dart';
import 'package:flutter/material.dart';

const KPrimaryColor=Color(0xff2B475E);
const kmessagesconection ="messages";
const kmessage ="message";
const time= "time";
Widget sinOut(context)=> TextButton(
  onPressed: ()
  {
    CachHealper.removeData(key: "uId").then((value)
    {
      if(value)
      {
        navigatorToReplasment(context,SocialLoginScreen ());
      }
    });
  },
  child: Text("تسجيل خروج"),
);