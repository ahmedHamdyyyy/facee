import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase/component/componenrs.dart';
import 'package:firebase/local/cach_helper.dart';
import 'package:firebase/shoichialAPP/Screens/HomScreen.dart';
import 'package:firebase/shoichialAPP/SoicialLogin/blokLoginSoictiall/cubit.dart';
import 'package:firebase/shoichialAPP/SoicialLogin/blokLoginSoictiall/stuts.dart';
import 'package:firebase/shoichialAPP/SoicialRegestration/blokRegestraion/SocialRegesrScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);
  var formSTAT = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerrEmail = TextEditingController();
    TextEditingController controllerrpassword = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLginStutes>(
        listener: (context, state) {
          if (state is SocialLoginErrorStates) {
            ShowToast(text: state.error, stute: ToustStute.ERROR);
          }

          if (state is SocialLoginSuccessStates) {
            CachHealper.SaveData(key: "uId", value: state.uId).then((value) {
              navigatorToReplasment(context, HomeScreen());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formSTAT,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 10,
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
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onFieldSubmitted: (S) {
                            if (formSTAT.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(
                                  email: controllerrEmail.text,
                                  password: controllerrpassword.text);
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
                              SocialLoginCubit.get(context).isPasswordShow,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            labelText: " Enter your password",
                            suffixIcon: IconButton(
                              onPressed: () {
                                SocialLoginCubit.get(context)
                                    .changPassoworsVisability();
                              },
                              icon:
                                  Icon(SocialLoginCubit.get(context).IconSufix),
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
                          condition: state is! SocialLoginlodingStates,
                          builder: (BuildContext context) {
                            return Container(
                              height: 50,
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formSTAT.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                        email: controllerrEmail.text,
                                        password: controllerrpassword.text);
                                  }
                                },
                                child: Text(
                                  "LOGIN",
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
                                "Don\'t have an account?",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  navigatorToReplasment(
                                      context, SocialRegestScreen());
                                },
                                child: Text(
                                  "Registration",
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
            ),
          );
        },
      ),
    );
  }
}
