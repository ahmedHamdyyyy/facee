import 'package:firebase/shoichialAPP/blokSoictialApp/cubit.dart';
import 'package:firebase/shoichialAPP/blokSoictialApp/stuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PostScreen extends StatelessWidget {
   PostScreen({Key? key}) : super(key: key);
  var NameControler=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStutes>(
          listener: (context, state) {},
          builder: (context, state) {
         return
            Scaffold(
           resizeToAvoidBottomInset: false,
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
              title: const Text('Create Posts'),
              actions: [
                TextButton(
                  onPressed: () {
                    var now=DateTime.now();
                    if(SocialCubit.get(context).postImage==null)
                    {
                      SocialCubit.get(context).CreatePost(dateTime:now.toString(),
                        // DateFormat('MMMM dd, yyyy - hh:mm aa')
                        //   .format(now)
                        //   .replaceAll('-', 'at'),
                          text: NameControler.text,);
                    }else
                    {
                      SocialCubit.get(context).UploadPostImage(dateTime:now.toString(),
                          text: NameControler.text,);
                    }

                  },
                  child: const Text(
                    'Posts',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is SocialCreatePostLoadingState)
                    LinearProgressIndicator(),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          "${SocialCubit.get(context).userModel!.image}",
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: Text(
                          "${SocialCubit.get(context).userModel!.name}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                   Expanded(
                    child: TextFormField(
                      controller:NameControler ,
                      decoration: InputDecoration(
                        hintText: "What is on your mind..?",
                      border: InputBorder.none,
                    ),
                    ),
                  ),
                  if(SocialCubit.get(context).postImage!=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(4,),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: (){
                            SocialCubit.get(context).removePostImage();

                          },
                          icon: CircleAvatar(
                            child: Icon(Icons.close,size: 20,), radius: 20,)),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImageGallary();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image_sharp),
                            SizedBox(width: 5,),
                            Text(
                              "add photo",
                            ),
                          ],
                        ),),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: (){},
                          child: Text(
                            "#add tags",
                          ),),
                      ),
                    ],
                  ),

                ],
              ),
            ),

          );
    });
  }
}
