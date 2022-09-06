import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase/component/componenrs.dart';
import 'package:firebase/local/cach_helper.dart';
import 'package:firebase/shoichialAPP/Screens/HomScreen.dart';
import 'package:firebase/shoichialAPP/SoicialLogin/blokLoginSoictiall/SocialLoginScreen%20.dart';
import 'package:firebase/shoichialAPP/SoicialRegestration/blokRegestraion/cubit.dart';
import 'package:firebase/shoichialAPP/SoicialRegestration/blokRegestraion/stuts.dart';
import 'package:firebase/shoichialAPP/constant/constant.dart';
import 'package:firebase/shoichialAPP/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegestScreen extends StatelessWidget {
  var formSTAT = GlobalKey<FormState>();
  TextEditingController controllerrEmail = TextEditingController();
  TextEditingController controllerrpassword = TextEditingController();
  TextEditingController controllerrName = TextEditingController();
  TextEditingController controllerrphone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>SocialRegestCubit(),
      child:BlocConsumer<SocialRegestCubit,SocialRegestStutes>(
        listener: (context, state) {

          /*if (state is SocialRegestErrorStates) {
            ShowToast(text: state.error, stute: ToustStute.ERROR);
          }

          if (state is SocialRegestlodingStates) {
            CachHealper.SaveData(key: "uId", value: state.uId).then((value) {
              navigatorToReplasment(context, HomeScreen());
            });
          }*/
        } ,
        builder: (context, state) {
          return Scaffold(
            backgroundColor:Colors.white ,
            appBar: AppBar(
              elevation: 0,
              backgroundColor:Colors.white ,
            ),
            body:SingleChildScrollView(

              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formSTAT,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "REGESTRATION",
                              style: TextStyle(
                                fontSize: 35, ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              onFieldSubmitted: (S) {
                                if (formSTAT.currentState!.validate())
                                {
                                  SocialRegestCubit.get(context).userRegest(
                                    email: controllerrEmail.text,
                                    password: controllerrpassword.text,
                                    name:controllerrName.text ,
                                    phone: controllerrphone.text,);
                                }
                              },
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "please Enter your name";
                                }
                              },
                              controller: controllerrName,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                labelText: " Enter your name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              onFieldSubmitted: (S) {
                                if (formSTAT.currentState!.validate()) {
                                  SocialRegestCubit.get(context).userRegest(
                                    email: controllerrEmail.text,
                                    password: controllerrpassword.text,
                                    name:controllerrName.text ,
                                    phone: controllerrphone.text,);
                                }
                              },
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "please Enter your phone";
                                }
                              },
                              controller: controllerrphone,
                              keyboardType: TextInputType.number,

                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                labelText: " Enter your phone",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: controllerrEmail,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "please Enter your Email";
                                } else
                                  return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: " Enter your Email",
                                prefixIcon: Icon(Icons.email_rounded),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            TextFormField(
                              onFieldSubmitted: (S) {
                                if (formSTAT.currentState!.validate()) {
                                  SocialRegestCubit.get(context).userRegest(
                                    email: controllerrEmail.text,
                                    password: controllerrpassword.text,
                                    name:controllerrName.text ,
                                    phone: controllerrphone.text,);
                                }
                              },
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "please Enter your password";
                                }
                              },
                              controller: controllerrpassword,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText:
                              SocialRegestCubit.get(context).isPasswordShow,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.key),
                                labelText: " Enter your password",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    SocialRegestCubit.get(context).changPassoworsVisabilityREGEST();
                                  },
                                  icon: Icon(SocialRegestCubit.get(context).IconSufix),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),


                            ConditionalBuilder(
                              condition: state is! SocialRegestlodingStates,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 50,
                                  width: double.infinity,
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (formSTAT.currentState!.validate()) {
                                        SocialRegestCubit.get(context).userRegest(
                                            email: controllerrEmail.text,
                                            password: controllerrpassword.text,
                                            name: controllerrName.text,
                                            phone: controllerrphone.text);
                                      }
                                    },
                                    child: Text(
                                      "REGEST",
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.indigo,
                                  ),
                                );
                              },
                              fallback: (BuildContext context) {
                                return Center(child: CircularProgressIndicator());
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    "I have an account",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      navigatorToReplasment(context, HomeScreen());

                                    },
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },

      ) ,);
  }
}
