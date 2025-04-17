import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muhaffiz_user/authentication/signup_screen.dart';
import 'package:muhaffiz_user/mainScreens/main_screen.dart';
import 'package:muhaffiz_user/splashScreen/splash_screen.dart';


import '../global/global.dart';
import '../widgets/progress_dialog.dart';


class LoginScreen extends StatefulWidget
{

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  validateForm()
  {

    if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email Address Not Valid");
    }
    else if(passwordTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password Is Required");
    }
    else
    {
        loginUserNow();
    }
  }

  loginUserNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message:"Processing,Please Wait");
        }
    );
    final User? firebaseUser =(
        await fAuth.signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg:"Error: " + msg.toString());
        })
    ).user;



    if(firebaseUser != null){
      DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
      usersRef.child(firebaseUser.uid).once().then((userKey){
        final snap=userKey.snapshot;
        if(snap.value != null)
          {
            currentFirebaseUser = firebaseUser;
            Fluttertoast.showToast(msg: "Login Successful");
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const MainScreen()));
          }
        else
          {
            Fluttertoast.showToast(msg: "No Record Found");
            fAuth.signOut();
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
          }
      });

    }
    else
    {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred During LogIn.");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/muhaffiz_user.png"),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Login As A Muhaffiz User",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style:const TextStyle(
                    color: Colors.white

                ),
                decoration:const InputDecoration(
                  labelText: "Email",
                  hintText: "Enter Email abc@gmail.com",

                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),labelStyle:TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                ),
              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style:const TextStyle(
                    color: Colors.white

                ),
                decoration:const InputDecoration(
                  labelText: "Password",
                  hintText: "Enter Password",

                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),labelStyle:TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                ),
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                onPressed: ()
                {
                 validateForm();

                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child:const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),

              TextButton(
                child:const Text(
                  "Don't Have An Account?Click to SignUp",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:(c)=>SignUpScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
