import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muhaffiz_driver/authentication/login_screen.dart';
import 'package:muhaffiz_driver/authentication/signup_screen.dart';
import 'package:muhaffiz_driver/global/global.dart';
import 'package:muhaffiz_driver/mainScreens/main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer()
  {
    Timer(const Duration(seconds: 3), () async
    {
      if(await fAuth.currentUser != null)
      {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
      }
    });
  }

  //startTimer()
  //{
    //Timer(const Duration(seconds: 8),() async{
      //send user to main screen
      //Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUpScreen()));
    //});
  //}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
          child: Image.asset("images/muhaffiz_driver_splashscreen.png"),
      ),
    );
  }
}
