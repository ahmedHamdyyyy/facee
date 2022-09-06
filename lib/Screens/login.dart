import 'package:firebase/Screens/chatScrren.dart';
import 'package:firebase/Screens/register.dart';
import 'package:firebase/component/buttom.dart';
import 'package:firebase/component/textForm.dart';
import 'package:firebase/conctants/conestants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);
  static String id ="login";

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  String? email, passward;

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
                          "LOGIN ",
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
                      TextInputTyp: TextInputType.emailAddress,
                      hint: " Email",
                      onchanged: (data) {
                        email = data;
                      },
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
                      text: "LOGIN",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLouded = true;
                          });
                          try {
                            await loginMethoud();
                            snaakbar(context,
                                "🤍التسجيل نجح ياصديقي🤍");

                        Navigator.pushNamed(context, Screen_chat.id);
                          } on FirebaseAuthException  catch (e) {
                            if (e.code == 'user-not-found') {
                              snaakbar(context," 😂المستخدم للاسف مش موجود ");
                            } else if (e.code == 'wrong-password') {
                          snaakbar(context, "..😂كلمه السر غلط ياوحش");
                            }
                          } catch (e) {
                            snaakbar(context, "في حاجه غلط");
                          }
                          setState(() {
                            isLouded = false;
                          });
                        }
                        else
                        {

                        }
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          "I dont have an acounnt?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              regester.id,
                            );
                          },
                          child: const Text(
                            "REGISTRATION",
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

  void snaakbar(BuildContext context, String massige) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.deepOrangeAccent,
        content: Text(massige),
      ),
    );
  }

  Future<void> loginMethoud() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: passward!);
  }
}
