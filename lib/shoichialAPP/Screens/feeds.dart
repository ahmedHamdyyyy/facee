 import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
 import 'package:firebase/shoichialAPP/blokSoictialApp/cubit.dart';
 import 'package:firebase/shoichialAPP/blokSoictialApp/stuts.dart';
 import 'package:firebase/shoichialAPP/models/PostModel.dart';
 import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';

 class feedsScreens extends StatelessWidget {
   const feedsScreens({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return BlocConsumer<SocialCubit, SocialStutes>(
         listener: (context, state) {},
         builder: (context, state) {
           return SocialCubit.get(context).posts.length==null?
           SingleChildScrollView(
             physics: BouncingScrollPhysics(),
             child: Column(
               children: [
                 Card(
                   elevation: 10,
                   margin: EdgeInsets.all(8),
                   clipBehavior: Clip.antiAliasWithSaveLayer,
                   child: Stack(
                     alignment: AlignmentDirectional.bottomEnd,
                     children: [
                       Image(
                         height: 220,
                         width: double.infinity,
                         fit: BoxFit.cover,
                         image: NetworkImage(
                           "https://img.freepik.com/free-photo/woman-working-from-home-laptop-with-empty-screen_53876-127275.jpg?w=900&t=st=1660365955~exp=1660366555~hmac=dacbfd0184fae884248eebbe8d846b07c62de9659ae5135f7b6e2dcdfacc4f98",
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text(
                           "Communicate with friends ",
                           style: TextStyle(
                             color: Colors.white,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                 ListView.separated(
                   physics: NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   itemBuilder: (context, index) =>  buildItemPost(SocialCubit.get(context).posts[index],context,index),
                   separatorBuilder: (context, index) => SizedBox(height: 8),
                   itemCount: SocialCubit.get(context).posts.length,),
                 SizedBox(height: 8,),

               ],
             )
           ):ConditionalBuilder(
             condition: SocialCubit.get(context).posts.length>0 && SocialCubit.get(context).userModel!=null,
             builder: (context) {
               return SingleChildScrollView(
                 physics: BouncingScrollPhysics(),
                 child: Column(
                   children: [
                     Card(
                       elevation: 10,
                       margin: EdgeInsets.all(8),
                       clipBehavior: Clip.antiAliasWithSaveLayer,
                       child: Stack(
                         alignment: AlignmentDirectional.bottomEnd,
                         children: [
                           Image(
                             height: 220,
                             width: double.infinity,
                             fit: BoxFit.cover,
                             image: NetworkImage(
                               "https://img.freepik.com/free-photo/woman-working-from-home-laptop-with-empty-screen_53876-127275.jpg?w=900&t=st=1660365955~exp=1660366555~hmac=dacbfd0184fae884248eebbe8d846b07c62de9659ae5135f7b6e2dcdfacc4f98",
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text(
                               "Communicate with friends ",
                               style: TextStyle(
                                 color: Colors.white,
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                     ListView.separated(
                       physics: NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       itemBuilder: (context, index) =>  buildItemPost(SocialCubit.get(context).posts[index],context,index),
                       separatorBuilder: (context, index) => SizedBox(height: 8),
                       itemCount: SocialCubit.get(context).posts.length,),
                     SizedBox(height: 8,),
                   ],
                 ),
               );
             } ,
             fallback: (context) =>Center(child: CircularProgressIndicator()) ,


           );
         });
   }
   Widget buildItemPost(  PostModel model,  context, int index)=> Card(
     elevation: 5,
     margin: EdgeInsets.symmetric(
       horizontal: 8,
     ),
     clipBehavior: Clip.antiAliasWithSaveLayer,
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             children: [
               CircleAvatar(
                 radius: 25,
                 backgroundImage: NetworkImage(
                   '${model.image}',
                 ),
               ),
               SizedBox(
                 width: 18,
               ),
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       '${model.name}',
                       style: TextStyle(
                           fontSize: 16, fontWeight: FontWeight.bold),
                     ),
                     Text(
                       '${model.dateTime}',
                       style: TextStyle(
                         color: Colors.grey,
                         fontSize: 13,
                       ),
                     ),
                   ],
                 ),
               ),
               SizedBox(
                 width: 18,
               ),
               IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
             ],
           ),
           Padding(
             padding: const EdgeInsets.symmetric(
               vertical: 15,
             ),
             child: Container(
               height: 1,
               width: double.infinity,
               color: Colors.grey[300],
             ),
           ),
           Text(
             '${model.text}',
             style: TextStyle(
               height: 1.2,
               fontWeight: FontWeight.w700,
               fontSize: 14,
             ),
           ),
           Container(
             width: double.infinity,
             child: Wrap(
               children: [
                 Container(
                   height: 25,
                   child: MaterialButton(onPressed: (){},
                     minWidth: 1,
                     padding: EdgeInsets.zero,
                     child:Text(
                       "#Image",
                       style: TextStyle(
                           fontSize: 13,
                           color: Colors.blue.shade600
                       ),
                     ) ,

                   ),
                 ),
                 Padding(
                   padding: const EdgeInsetsDirectional.only(
                       end: 10
                   ),
                   child: Container(
                     height: 25,
                     child: MaterialButton(onPressed: (){},
                       minWidth: 1,
                       padding: EdgeInsets.zero,
                       child:Text(
                         "#Flutter",
                         style: TextStyle(
                             fontSize: 13,
                             color: Colors.blue.shade600
                         ),
                       ) ,
                     ),
                   ),
                 ),
               ],
             ),
           ),
           if(model.postImage != '')
           Padding(
             padding: const EdgeInsetsDirectional.only(
               top: 15,
             ),
             child: Container(
               height: 250,
               width: double.infinity,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(5),
                 image: DecorationImage(
                   fit: BoxFit.cover,
                   image: NetworkImage(
                     '${model.postImage}',
                   ),
                 ),

               ),
             ),
           ),
           Row(
             children: [
               Expanded(
                 child: InkWell(
                   child: Padding(
                     padding: const EdgeInsets.symmetric(
                         vertical: 5
                     ),
                     child: Row(
                       children: [
                         Icon(
                           Icons.favorite_border,
                           color: Colors.red,
                           size: 20,
                         ),
                         SizedBox(width: 4,),
                         Text('${SocialCubit.get(context).likes[index]}'),
                       ],
                     ),
                   ),
                   onTap: (){},
                 ),
               ),
               Expanded(
                 child: InkWell(
                   child: Padding(
                     padding: const EdgeInsets.symmetric(
                         vertical: 5
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Icon(
                           Icons.messenger_outline_sharp,
                           color: Colors.amber,
                           size: 20,
                         ),
                         SizedBox(width: 5,),
                         Text("200"),
                         SizedBox(width: 5,),
                         Text("comment"),
                       ],
                     ),
                   ),
                   onTap: (){},
                 ),
               ),
             ],
           ),
           Padding(
             padding: const EdgeInsets.only(bottom: 10),
             child: Container(
               height: 1,
               width: double.infinity,
               color: Colors.grey[300],),
           ),
           Row(
             children: [
               Expanded(
                 child: InkWell(
                   child: Row(
                     children: [
                       CircleAvatar(
                         radius: 15,
                         backgroundImage: NetworkImage(
                           '${SocialCubit.get(context).userModel!.image}',                        ),
                       ),
                       SizedBox(
                         width: 18,
                       ),
                       Text(
                         "Write a comment...",
                         style: TextStyle(
                           color: Colors.black,
                           fontSize: 13,
                         ),
                       ),
                     ],
                   ),
                   onTap: (){},
                 ),
               ),
               InkWell(
                 child: Row(
                   children: [
                     Icon(
                       Icons.favorite_border,
                       color: Colors.red,
                       size: 20,
                     ),
                     SizedBox(width: 4,),
                     Text("Like",style: TextStyle(
                         fontWeight: FontWeight.w700
                     ),),
                   ],
                 ),
                 onTap: (){
                   SocialCubit.get(context).LikePost(
                    postId:   SocialCubit.get(context).postsId[index],
                   );
                 },
               ),
             ],
           ),
         ],
       ),
     ),
   );
 }
