import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase/component/componenrs.dart';
import 'package:firebase/shoichialAPP/Screens/CHATS/chat.dart';
import 'package:firebase/shoichialAPP/blokSoictialApp/cubit.dart';
import 'package:firebase/shoichialAPP/blokSoictialApp/stuts.dart';
import 'package:firebase/shoichialAPP/models/SoicialUserModel.dart';
import 'package:firebase/shoichialAPP/models/modelMessanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
   ChatsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStutes>(
      listener: (context, state) {},
      builder: (context, state) {
        return  ConditionalBuilder(
          condition:SocialCubit.get(context).users.length>0, //SocialCubit.get(context).users!.isNotEmpty,
          builder: (context) => ListView.separated(

            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(SocialCubit.get(context).users[index], context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context) =>  const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
    onTap: () {
navigatorTo(context, ChatScreenHAMDI(
   userModel: model,

));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              '${model.image}',
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${model.name}',
            style: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    ),
  );
}

