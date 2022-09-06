import 'dart:developer';
import 'package:firebase/component/componenrs.dart';
import 'package:firebase/conctants/conestants/constants.dart';
import 'package:firebase/shoichialAPP/Screens/Edite.dart';
import 'package:firebase/shoichialAPP/blokSoictialApp/cubit.dart';
import 'package:firebase/shoichialAPP/blokSoictialApp/stuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStutes>(
      listener: (context, state) {},
      builder: (context, state) {
       var userModel = SocialCubit.get(context).userModel;
        return userModel== null
        ? Center(
        child: CircularProgressIndicator(),
        ): Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:  BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage('${userModel.cover??""}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(

                        radius: 59,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage('${userModel.image??""}'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${userModel.name}',
                  style:
                  const TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                ),
                Text("${userModel.bio}"),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: const [
                              Text(
                                '100',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 17),
                              ),
                              Text('Posts'),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: const [
                              Text(
                                '42',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 17),
                              ),
                              Text('Photos'),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: const [
                              Text(
                                '497',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 17),
                              ),
                              Text('Follower'),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: const [
                              Text(
                                '190',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 17),
                              ),
                              Text('Following'),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {

                        },
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 17),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {navigatorTo(context, EditProfileScreen());
                           Navigator.push(
                            context, MaterialPageRoute(
                                builder: (context) => EditProfileScreen()));

                      },
                      child: const Icon(Icons.edit),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    sinOut(context),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}

