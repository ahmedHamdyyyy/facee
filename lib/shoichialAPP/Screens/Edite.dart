import 'dart:io';

import 'package:firebase/component/componenrs.dart';
import 'package:firebase/shoichialAPP/blokSoictialApp/cubit.dart';
import 'package:firebase/shoichialAPP/blokSoictialApp/stuts.dart';
import 'package:firebase/shoichialAPP/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var EmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStutes>(listener: (context, state) {
      if (state is SocialUserUpdateLoadingStates) {
        ShowToast(text: "جار تحميل الصوره", stute: ToustStute.WORNNING);
        /*if (state is SocialUpLoudProfileImageSuccessStates) {
          ShowToast(text: "جارالصوره", stute: ToustStute.WORNNING);
        }*/
      }
    }, builder: (context, state) {
     dynamic userModel = SocialCubit.get(context).userModel;
     dynamic profileImage = SocialCubit.get(context).ProfileImage;
     dynamic coverImage = SocialCubit.get(context).CoverImage;

      nameController.text = userModel!.name!;
      bioController.text = userModel.bio!;
      phoneController.text = userModel.phone!;
      EmailController.text = userModel.email!;

      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 5.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
            ),
          ),
          title: const Text('Edit Profile'),
          actions: [
            TextButton(
              onPressed: () {
                SocialCubit.get(context).UpdateUser(
                  name: nameController.text,
                  phone: phoneController.text,
                  bio: bioController.text,
                  email: EmailController.text,
                );
              },
              child: const Text(
                'UPDATE',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (state is SocialUserUpdateLoadingStates)
                  LinearProgressIndicator(),
                // if (state is  SocialUserUpdateLoadingStates)
                Container(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                                image: DecorationImage(
                                  image: coverImage == null
                                      ? NetworkImage('${userModel.cover}')
                                      : FileImage(coverImage) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).UpdateUser(
                                    name: nameController.text,
                                    email: EmailController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    size: 20,
                                  ),
                                  radius: 20,
                                )),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 59,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 55,
                              backgroundImage: profileImage == null
                                  ? NetworkImage('${userModel.image}')
                                  : FileImage(profileImage) as ImageProvider,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                SocialCubit.get(context).UpdateUser(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                  email: EmailController.text,
                                );
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 20,
                                ),
                                radius: 20,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10.0,
                ),
                if (SocialCubit.get(context).ProfileImage != null ||
                    SocialCubit.get(context).CoverImage != null)
                  Row(
                    children: [
                      if (SocialCubit.get(context).ProfileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(defaultColor),
                                ),
                                onPressed: () {
                                  SocialCubit.get(context).upLoudProfilImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: EmailController.text,
                                      bio: bioController.text);
                                },
                                child: const Text(
                                  '    Upload Profile     ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              if (state is SocialUserUpdateLoadingStates)
                                const SizedBox(width: 5),
                              if (state is SocialUserUpdateLoadingStates)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      const SizedBox(width: 20),
                      if (SocialCubit.get(context).CoverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(defaultColor),
                                ),
                                onPressed: () {
                                  SocialCubit.get(context).upLoudProfilCover(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: EmailController.text,
                                      bio: bioController.text);
                                },
                                child: const Text(
                                  '    Upload Cover    ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              if (state is SocialUserUpdateLoadingStates)
                                const SizedBox(width: 5),
                              if (state is SocialUserUpdateLoadingStates)
                                LinearProgressIndicator(),
                              //  LinearProgressIndicator(),
                            ],
                          ),
                        ),
                    ],
                  ),
                if (SocialCubit.get(context).ProfileImage != null ||
                    SocialCubit.get(context).CoverImage != null)
                  SizedBox(
                    height: 20,
                  ),
                defaultTextFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Name must not be empty';
                    }
                    return null;
                  },
                  label: 'Name',
                  prefix: Icons.person,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                defaultTextFormField(
                  controller: bioController,
                  type: TextInputType.name,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'bio must not be empty';
                    }
                    return null;
                  },
                  label: 'bio',
                  prefix: Icons.info_outline,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                defaultTextFormField(
                  controller: phoneController,
                  type: TextInputType.number,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'phone must not be empty';
                    }
                    return null;
                  },
                  label: 'phone',
                  prefix: Icons.phone_iphone,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                defaultTextFormField(
                  controller: EmailController,
                  type: TextInputType.emailAddress,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'email must not be empty';
                    }
                    return null;
                  },
                  label: 'Email',
                  prefix: Icons.email,
                ),

                /* if ( false state is SocialUserUpdateLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 10),
                    Container(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 160,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage(userModel.cover!)
                                          : FileImage(coverImage)
                                      as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: defaultColor,
                                  child: IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).updateUser(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: const Icon(
                                     Icons.camera,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 59,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(userModel.image!)
                                      : FileImage(profileImage)
                                  as ImageProvider,
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: defaultColor,
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).updateUser(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      Row(
                        children: [
                          if (SocialCubit.get(context).profileImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                    function: () {
                                      SocialCubit.get(context)
                                          .uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                    text: 'Upload Profile',
                                    background: defaultColor,
                                    isUpperCase: false,
                                  ),
                                  if (state is SocialUserUpdateLoadingState)
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                  if (state is SocialUserUpdateLoadingState)
                                    const LinearProgressIndicator(),
                                ],
                              ),
                            ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          if (SocialCubit.get(context).coverImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  defaultButton(
                                    function: () {
                                      SocialCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                    text: 'Upload Cover',
                                    background: defaultColor,
                                    isUpperCase: false,
                                  ),
                                  if (state is SocialUserUpdateLoadingState)
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                  if (state is SocialUserUpdateLoadingState)
                                    const LinearProgressIndicator(),
                                ],
                              ),
                            ),
                        ],
                      ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      const SizedBox(
                        height: 20.0,
                      ),
                    defaultTextFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultTextFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Bio must not be empty';
                        }
                        return null;
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultTextFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: IconBroken.Call,
                    ),*/
              ],
            ),
          ),
        ),
      );
    });
  }
}
