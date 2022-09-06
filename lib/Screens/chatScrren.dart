import 'package:firebase/conctants/conestants/constants.dart';
import 'package:firebase/model/message.dart';
import 'package:firebase/scrren/Chat_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Screen_chat extends StatelessWidget {
  CollectionReference messages = FirebaseFirestore.instance.collection(kmessagesconection);
  TextEditingController CONTROLER = TextEditingController();
  ScrollController ScrollCONTROLER=ScrollController();

  static String id = "Screen_chat";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(

      stream: messages.orderBy(time,descending: true).snapshots(),/*Stream<QuerySnapshot> */
      builder: (context, snapshot) {


        if(snapshot.hasData)
        {
          List<Message> messageList=[];
          for( int i=0; i<snapshot.data!.docs.length; i++)
          {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }

          return  Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  radius: 14,
                  child: Icon(Icons.arrow_back_ios_sharp),
                ),
              ),
              actions: [
                Container(
                  height: 40,
                   width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),


                  ),
                  child:   Icon(Icons.person,
                    color:   Color(0xff2B475E),

                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller:ScrollCONTROLER ,
                      itemBuilder: (context, index) => chatBuble(
                      messag: messageList[index],
                      ),
                      itemCount: messageList.length),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: CONTROLER,
                    onFieldSubmitted: (data) {
                      messages.add({
                        kmessage: data,
                        time:DateTime.now()
                      });
                      CONTROLER.clear();
                      ScrollCONTROLER.animateTo(0 ,
                          duration: Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn);
                    },
                    decoration: InputDecoration(
                        hintText: "Send Massage",
                        suffixIcon: Icon(
                          Icons.send,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.lightBlue,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          );
        }else
        {
          return CircularProgressIndicator(

          );
        }
      },
    );
  }
}
