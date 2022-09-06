import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase/shoichialAPP/blokSoictialApp/cubit.dart';
import 'package:firebase/shoichialAPP/blokSoictialApp/stuts.dart';
import 'package:firebase/shoichialAPP/constant/constant.dart';
import 'package:firebase/shoichialAPP/models/SoicialUserModel.dart';
import 'package:firebase/shoichialAPP/models/modelMessanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreenHAMDI extends StatelessWidget {
  SocialUserModel? userModel;
  var controller=TextEditingController();
  MessageModel?messs;

  ChatScreenHAMDI({
    required this.userModel,
  }) ;
  @override
  Widget build(BuildContext context) {
    return  Builder(builder: (context) {

      SocialCubit.get(context).getMessage(receiverId: userModel!.uId!);
      return  BlocConsumer<SocialCubit, SocialStutes>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 1,
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        userModel!.image!,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      userModel!.name!,
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [Expanded(

                    child: ListView.separated(
                        itemBuilder: (context, index) {
                      var MESSAGE = SocialCubit.get(context).messages[index];
                      if (SocialCubit.get(context).userModel!.uId == MESSAGE.senderId)
                        return buildMessage(MESSAGE);

                             return buildMyMessage(MESSAGE);
                    },
                        separatorBuilder: (context, index) => SizedBox(height: 1,),
                        itemCount: SocialCubit.get(context).messages.length),
                  ),


                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 1,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: TextFormField(
                                controller: controller,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'write your message here...',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            child: MaterialButton(
                              color: defaultColor.withOpacity(.9),
                              minWidth: 1.0,
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(receiverId: userModel!.uId!,
                                  text: controller.text,
                                  dateTime: DateTime.now().toString(),
                                );
                                controller.clear();
                              },

                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } );
    } ,

    );
  }
  Widget buildMyMessage(MessageModel MODEL)=>Align(
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
        color: Color(0xff2B515E),
      ),
      child: Text(
        MODEL.text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
  Widget buildMessage(MessageModel MODEL)=>Align(
    alignment: Alignment.centerRight,
    child: Container(
      //alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.only(left: 16, top: 20, bottom: 20, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(0),
        ),
        color: Colors.blue,
      ),
      child: Text(
         MODEL.text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}


