import 'package:firebase/Screens/chatScrren.dart';
import 'package:firebase/Screens/snakbar.dart';
import 'package:firebase/component/buttom.dart';
import 'package:firebase/component/textForm.dart';
import 'package:firebase/conctants/conestants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class regester extends StatefulWidget {
  regester({Key? key}) : super(key: key);
  static String id = "Registration";

  @override
  State<regester> createState() => _regesterState();
}

class _regesterState extends State<regester> {
  String? email;

  String? passward;
  bool isLouded = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLouded,
      child: Scaffold(
        backgroundColor: KPrimaryColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset("assets/images/scholar.png"),
                    Text(
                      "Scholar chat ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Text(
                          "REGISTRATION",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormFiled(
                      onchanged: (data) {
                        email = data;
                      },
                      TextInputTyp: TextInputType.emailAddress,
                      hint: " Email",
                      IconPrefex: Icons.email,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormFiled(
                      onchanged: (data) {
                        passward = data;
                      },
                      IconPrefex: Icons.key,
                      TextInputTyp: TextInputType.visiblePassword,
                      hint: " Password",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    coustoumBotum(
                      text: "REGISTRATION  ",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLouded = true;
                          });
                          try {
                            await registerMethoud();
                            snaakbar(context,
                                "🤍التسجيل نجح ياصديقي🤍");
                            Navigator.pushNamed(context, Screen_chat.id);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              snaakbar(context, "الباسورد ضعيف ياوحش");
                            } else if (e.code == 'email-already-in-use') {
                              snaakbar(context,  "الاميل موجود بالفعل..");
                            }
                          }
                          catch (e) {
                            snaakbar(context, "في حاجه غلط");
                          }
                          setState(() {
                            isLouded = false;
                          });

                        }else
                        {

                        }
                      },
                    ),
                    Row(
                      children: [
                        const Text(
                          "already i have an account ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }





  Future<void> registerMethoud() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: passward!);
  }
}
