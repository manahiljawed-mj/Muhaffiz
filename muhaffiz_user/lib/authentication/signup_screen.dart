import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muhaffiz_user/authentication/login_screen.dart';
import 'package:muhaffiz_user/splashScreen/splash_screen.dart';

import '../global/global.dart';
import '../widgets/progress_dialog.dart';

class SignUpScreen extends StatefulWidget {


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  validateForm()
  {
    if(nameTextEditingController.text.length < 3)
      {
        Fluttertoast.showToast(msg: "Name Must Be More Than 3 Characters");

      }
    else if(!emailTextEditingController.text.contains("@"))
      {
        Fluttertoast.showToast(msg: "Email Address Not Valid");
      }
    else if(phoneTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Phone Number Is Mandatory");
    }
    else if(passwordTextEditingController.text.length<6)
    {
      Fluttertoast.showToast(msg: "Password Must Be Atleast 6 Characters");
    }
    else
      {
        saveUserInfoNow();
      }
  }
  saveUserInfoNow() async
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
        await fAuth.createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg:"Error: " + msg.toString());
        })
    ).user;

   if(firebaseUser != null){
     Map userMap = {
       "id":firebaseUser.uid,
       "name":nameTextEditingController.text.trim(),
       "email":emailTextEditingController.text.trim(),
       "phone":phoneTextEditingController.text.trim(),
     };

     DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
     usersRef.child(firebaseUser.uid).set(userMap);

     currentFirebaseUser = firebaseUser;
     Fluttertoast.showToast(msg: "Account Has Been Created");
     Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
   }
   else
     {
       Navigator.pop(context);
       Fluttertoast.showToast(msg: "Account Has Not Been Created.");
     }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset("images/muhaffiz_user.png"),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Register As A Muhaffiz User",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: nameTextEditingController,
                keyboardType: TextInputType.text,
                style:const TextStyle(
                  color: Colors.white

                ),
                decoration:const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter Name",

                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),labelStyle:TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
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
                    fontSize: 12,
                  ),labelStyle:TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                ),
              ),
              TextField(
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style:const TextStyle(
                    color: Colors.white

                ),
                decoration:const InputDecoration(
                  labelText: "Phone",
                  hintText: "Enter Phone Number",

                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),labelStyle:TextStyle(
                  color: Colors.white,
                  fontSize: 14,
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
                    fontSize: 12,
                  ),labelStyle:TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: ()
                {
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child:const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                child:const Text(
                  "Already Have An Account?Click to Login",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:(c)=>LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
