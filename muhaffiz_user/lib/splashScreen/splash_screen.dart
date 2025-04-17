import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muhaffiz_user/authentication/login_screen.dart';
import 'package:muhaffiz_user/mainScreens/main_screen.dart';
import 'package:muhaffiz_user/selection_screen_main/option_selection.dart';

import '../assistants/assistant_methods.dart';
import '../global/global.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer()
  {
    fAuth.currentUser !=null ? AssistantMethods.readCurrentOnlineUserInfo() : null;
    Timer(const Duration(seconds: 03), () async
    {
      if(await fAuth.currentUser != null)
      {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
        //Navigator.push(context, MaterialPageRoute(builder: (c)=> OptionSelectionScreen()));
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
          child: Image.asset("images/muhaffiz_basic_life_support.png"),
      ),
    );
  }
}
