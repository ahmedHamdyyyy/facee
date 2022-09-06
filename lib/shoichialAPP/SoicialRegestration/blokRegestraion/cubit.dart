import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/shoichialAPP/SoicialRegestration/blokRegestraion/stuts.dart';
import 'package:firebase/shoichialAPP/constant/constant.dart';
import 'package:firebase/shoichialAPP/constant/constant.dart';
import 'package:firebase/shoichialAPP/models/SoicialUserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegestCubit extends Cubit<SocialRegestStutes> {
  SocialRegestCubit() : super(SocialRegestInitialStates());
  static SocialRegestCubit get(context) => BlocProvider.of(context);
  IconData IconSufix = Icons.remove_red_eye_rounded;
  bool isPasswordShow = true;

  void changPassoworsVisabilityREGEST() {
    isPasswordShow = !isPasswordShow;
    IconSufix = isPasswordShow ? Icons.remove_red_eye_rounded : Icons.visibility_off;
    emit(SocialchangedPasswordStatesREGES());
  }

  void userRegest({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {

    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      emit(SocialRegestlodingStates());
        userCreated(
          email:email ,
          uId:value.user!.uid,
          name:name ,
          password: password,
          phone:phone ,
        );

    }).catchError((e) {
      emit(SocialRegestErrorStates(e.toString()));
    });

  }

  void userCreated({
    required String email,
    required String phone,
    required String name,
    required String uId,
    required String password,

  }) {
    SocialUserModel model = SocialUserModel(
      phone: phone,
      name: name,
      email: email,
      uId: uId,
      password: password ,
      cover: 'https://img.freepik.com/free-photo/young-man-learning-virtual-classroom_23-2149200163.jpg?w=900&t=st=1660504348~exp=1660504948~hmac=7f2b41dc2cf31ce37ba7026bb93e8104ca5e64deb713defab273f9a4dfbe146c',
      bio: "write a bio here.",
      image:'https://img.freepik.com/free-photo/young-man-learning-virtual-classroom_23-2149200163.jpg?w=900&t=st=1660504348~exp=1660504948~hmac=7f2b41dc2cf31ce37ba7026bb93e8104ca5e64deb713defab273f9a4dfbe146c',

    );
    FirebaseFirestore.instance.collection("users")
        .doc(uId).set(model.toMap(),).then((value)

        {
        emit(SocialCreateSuccessStates());
        }).catchError((e){
          emit(SocialCreateErrorStates(e.toString()));
    });
  }
}
