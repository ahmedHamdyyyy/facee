
import 'package:firebase/local/dio.dart';
import 'package:firebase/shoichialAPP/SoicialLogin/blokLoginSoictiall/stuts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';






class SocialLoginCubit extends Cubit<SocialLginStutes>
{
  SocialLoginCubit():super (SocialLoginInitialStates());
  static SocialLoginCubit get(context)=>BlocProvider.of(context);
  IconData IconSufix= Icons.remove_red_eye_rounded;
  bool isPasswordShow=true;

  void changPassoworsVisability()
  {
    isPasswordShow= !isPasswordShow;
    IconSufix=isPasswordShow?Icons.remove_red_eye_rounded:Icons.visibility_off;
    emit(SocialchangedPasswordStates());

  }



  void userLogin({required String email,required String password})
  {
    emit(SocialLoginlodingStates());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,).
    then((value) {
    //   print(value.user!.email);
    // print(value.user!.uid);
      emit(SocialLoginSuccessStates(value.user!.uid));
    }).catchError((e)
    {
      emit(SocialLoginErrorStates(e.toString()));
    });

  }

}