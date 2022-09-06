import 'package:firebase/local/cach_helper.dart';
import 'package:firebase/local/observal.dart';
import 'package:firebase/shoichialAPP/Screens/HomScreen.dart';
import 'package:firebase/shoichialAPP/SoicialLogin/blokLoginSoictiall/SocialLoginScreen%20.dart';
import 'package:firebase/shoichialAPP/blokSoictialApp/cubit.dart';
import 'package:firebase/shoichialAPP/constant/constant.dart';
import 'package:firebase/shoichialAPP/models/modelMessanger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHealper.init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MessageModel?messs;
  Widget widget;
    uId= CachHealper.getDBoollen(key: "uId");
    if(uId != null)
    {
      widget=HomeScreen();
    }else
    {
      widget=SocialLoginScreen();
    }

  print('firebase.currentuser : ${FirebaseAuth.instance.currentUser!.email}');
  print('firebase.currentuser : ${FirebaseAuth.instance.currentUser!.phoneNumber}');
  print(uId);
  runApp( MyApp(
   startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
   MyApp({ required this.startWidget});
  @override

  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SocialCubit()..getUserData()..getPosts(),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: Colors.white,
          floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark),
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.deepOrange,
          scaffoldBackgroundColor: HexColor("333739"),
          floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor("333739"),
                statusBarIconBrightness: Brightness.dark),
            backgroundColor: HexColor("333739"),
            elevation: 0.0,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            backgroundColor: HexColor("333739"),
          ),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}
