import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase/component/componenrs.dart';
import 'package:firebase/shoichialAPP/Screens/CHATS/chat.dart';
import 'package:firebase/shoichialAPP/Screens/postes.dart';
import 'package:firebase/shoichialAPP/blokSoictialApp/cubit.dart';
import 'package:firebase/shoichialAPP/blokSoictialApp/stuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStutes>(
      listener: (context, state) {
        if (state is SocialNewPostStates) {
          navigatorTo(context, PostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.CurrentIndex]),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search_sharp,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_active_outlined,
                    size: 30,
                  )),
            ],
          ),
          body: cubit.Screenss[cubit.CurrentIndex],
          /*     bottomNavigationBar: CurvedNavigationBar(
                  index: cubit.CurrentIndex,
                  animationDuration:Duration(
                    milliseconds: 400,
                  ) ,
                  backgroundColor: Colors.deepOrangeAccent,
                  items: [
                     Icon(Icons.person),
                    Icon(Icons.home, ),
                    Icon(Icons.chat, ),

                  ],
                  onTap: (index) {
                   cubit.butttomNavigat(index);
                  },
                ),*/

          bottomNavigationBar: BottomNavigationBar(
            onTap: (i) {
              cubit.butttomNavigat(i);
            },
            currentIndex: cubit.CurrentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.post_add), label: "add post"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Users"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "settings"),
            ],
          ),
        );
      },
    );
  }
}
