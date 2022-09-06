import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/component/componenrs.dart';
import 'package:firebase/local/cach_helper.dart';
import 'package:firebase/shoichialAPP/Screens/CHATS/ChatsScreen.dart';
import 'package:firebase/shoichialAPP/Screens/feeds.dart';
import 'package:firebase/shoichialAPP/Screens/postes.dart';
import 'package:firebase/shoichialAPP/Screens/sittings.dart';
import 'package:firebase/shoichialAPP/Screens/users.dart';
import 'package:firebase/shoichialAPP/blokSoictialApp/stuts.dart';
import 'package:firebase/shoichialAPP/constant/constant.dart';
import 'package:firebase/shoichialAPP/models/PostModel.dart';
import 'package:firebase/shoichialAPP/models/SoicialUserModel.dart';
import 'package:firebase/shoichialAPP/models/modelMessanger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;

import '../SoicialLogin/blokLoginSoictiall/SocialLoginScreen .dart';



class SocialCubit extends Cubit<SocialStutes> {
  SocialCubit() : super(SocialInitiallStates());
  static SocialCubit get(context) => BlocProvider.of(context);
  int CurrentIndex = 0;
  List<Widget> Screenss = [
    feedsScreens(),
    ChatsScreen(),
    PostScreen(),
    UsersScreens(),
    SettingsScreen(),
  ];
  List<String> titles =
  [
    "Home",
    "Chats",
    "post",
    "Users",
    "Settings",
  ];

  void butttomNavigat(int index) {
    if(index==1){
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostStates());
    }

    else {
      CurrentIndex = index;
      emit((ChangBouttomNavStute()));
    }
  }
  /*void signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      emit(SocialSinOutLoudingStates());
       CachHealper.removeData(key: "uId").then((value)
       {

         if(value)
         {
           navigatorToReplasment(context,SocialLoginScreen ());
         }
         emit(SocialSinOutSuccessStates());
       });
    });

  }*/
   // void sinOut(context){
   //  emit(SocialSinOutLoudingStates());
   //
   //   CachHealper.removeData(key: "uId").then((value)
   //   {
   //
   //     if(value)
   //     {
   //       navigatorToReplasment(context,SocialLoginScreen ());
   //     }
   //     emit(SocialSinOutSuccessStates());
   //   });
   // }
  SocialUserModel? userModel;

  void getUserData()
  {
    emit(SocialGetUserLoadingStates());


     FirebaseFirestore.instance.collection("users").doc(uId).get ().then((value) {
       userModel=SocialUserModel.fromJson(value.data()!);
       print(userModel!.uId);

       emit(SocialGetUserSuccessStates());
}).catchError((e){
  emit(SocialGetUserErrorStates(e.toString()));
     });
  }


  File? ProfileImage;
  var picker =ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      ProfileImage = File(pickedFile.path);
      emit( SocialProfileImagePeckerSuccessStates ());
    } else {
      print('No Image Selected!');
      emit(SocialProfileImagePeckerErrorStates());
    }
  }


  void upLoudProfilImage({
    required String name,
    required String phone,
    required String email,
    required String bio,
    })
  {
    emit(SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance.ref().child("users/${Uri.file(ProfileImage!.path).
    pathSegments.last}").putFile(ProfileImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        UpdateUser(
          bio: bio,
          name: name,
          phone: phone,
          email: email,
          image: value,
        );
        //emit(SocialUpLoudProfileImageSuccessStates());
      }).catchError((e)
      {
        emit(SocialUpLoudProfileImageErrorStates());
      });
    }).catchError((e){

      emit(SocialUpLoudProfileImageErrorStates());
    });
  }


  File? CoverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      CoverImage = File(pickedFile.path);
      emit( SocialProfileCoverPeckerSuccessStates ());
    } else {
      print('No Image Selected!');
      emit(SocialProfileCoverPeckerErrorStates());
    }
  }
  void upLoudProfilCover({
    required String name,
    required String phone,
    required String email,
    required String bio,

})
  {
 emit( SocialUserUpdateLoadingStates());
    firebase_storage.FirebaseStorage.instance.ref().
    child("users/${Uri.file(CoverImage!.path).
    pathSegments.last}").putFile(CoverImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        UpdateUser(
          bio: bio,
          name: name,
          phone: phone,
          email: email,
          cover: value,
        );
        //emit(SocialUpLoudProfileCoverSuccessStates());
      }).catchError((e)
      {
        emit(SocialUpLoudProfileCoverErrorStates());
      });
    }).catchError((e){
      emit(SocialUpLoudProfileCoverErrorStates());
    });
  }

/*  void UpdateUserImages({
  required String name,
    required String phone,
    required String email,
    required String bio,
})

  {
    emit(SocialLodingUserUpdateErrorStates());
    if(CoverImage !=null){
      upLoudProfilCover();
    }else if (ProfileImage !=null)
    {
      upLoudProfilImage();
    } else if (CoverImage !=null&&ProfileImage !=null)
    {

    }
    else
    {
      UpdateUser(
        email: email,
        phone: phone,
        name: name,
        bio: bio,
      );
    }

  }*/
  void UpdateUser(
  { required String name,
    required String phone,
    required String email,
    required String bio,
    String? image,
    String? cover,})
  {
    SocialUserModel model = SocialUserModel(
      phone: phone,
      name: name,
      bio: bio,
      email: email,
      cover: cover ?? userModel!.cover,
      image: image?? userModel!.image,
      uId: userModel!.uId,

    );
    FirebaseFirestore.instance.collection("users").doc(userModel!.uId).update(model.toMap())
        .then((value)
    {
      getUserData();

    }).catchError((e)
    {
      emit(SocialUserUpdateErrorStates());
    });
  }



  //Create post
  File? postImage;
  Future<void> getPostImageGallary() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit( SocialPostImagePeckerSuccessStates ());
    } else {
      print('No Image Selected!');
      emit(SocialPostImagePeckerErrorStates());
    }
  }

  void UploadPostImage({
    required String dateTime,
    required String text,
  })
  {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child("posts/${Uri.file(postImage!.path).
    pathSegments.last}").putFile(postImage!).then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUpLoudProfileImageSuccessStates());
     /*   UpdateUser(
          bio: bio,
          name: name,
          phone: phone,
          email: email,
          image: value,
        );*/
        CreatePost(
            postImage: value,
            dateTime: dateTime,
            text: text);
        emit(SocialCreatePostErrorState());
      });
      }).catchError((e)
      {
    }).catchError((e){

      emit(SocialCreatePostErrorState());
    });
  }
  void CreatePost(
      {required String dateTime,
        required String text,
        String? postImage,})
  {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
       text: text,
      image: userModel!.image,
      dateTime: dateTime,
      postImage: postImage ?? '',

    );
    FirebaseFirestore.instance.collection("posts").add(model.toMap())
        .then((value)
    {
      emit(SocialCreatePostSuccessState());

    }).catchError((e)
    {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    posts = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get(
        ).then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          }).catchError((error) {});

      });
      emit(SocialGetPostsSuccessStates());
    }).catchError((error) {
      emit(SocialGetPostsErrorStates(error.toString()));
    });
  }
  void LikePost({
    String? postId,
    PostModel? postModel,
  })
  {
    FirebaseFirestore.instance.collection("posts").doc(postId).
    collection("likes").doc(userModel!.uId).set({
      "like":true,
    }).then((value)
    {
      emit(SocialLikePostsSuccessStates());

    }).catchError((E){
      emit(SocialLikePostsErrorStates(E.toString(),));

    });
  }
  //
  List<SocialUserModel> users=[];

  void getUsers() {
  if (users.length==0)
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != userModel!.uId)
          users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUsersSuccessStates());
    }).catchError((error) {
      emit(SocialGetUserErrorStates(error.toString()));
    //  log(error.toString());
    });
  }
  MessageModel ? messageModel;
  //SendMessage
  void sendMessage({
    required String receiverId,
    required String text,
    required String dateTime,
  }) {
    MessageModel model3 = MessageModel(
      text: text,
      senderId: userModel!.uId,
      dateTime: dateTime,
      receiverId: receiverId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model3.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessStates());
    }).catchError((error) {
      emit(SocialSendMessageErrorStates(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model3.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessStates());
    }).catchError((error) {
      emit(SocialSendMessageErrorStates(error.toString()));
    });

  }

  List<MessageModel> messages = [];
  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime', )
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessStates());
    });
  }


}
