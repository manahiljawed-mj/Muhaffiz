import 'package:flutter/material.dart';
import 'package:muhaffiz_user/splashScreen/splash_screen.dart';
import 'package:muhaffiz_user/splashScreen/splash_screen_als.dart';
import 'package:muhaffiz_user/splashScreen/splash_screen_patient_tranfer.dart';

class OptionSelectionScreen extends StatefulWidget {
  const OptionSelectionScreen({Key? key}) : super(key: key);
  @override
  State<OptionSelectionScreen> createState() => _OptionSelectionScreenState();
}

class _OptionSelectionScreenState extends State<OptionSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/muhaffiz_user_scaffold.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ) ,
                  child: Text('Choose The Purpose of Booking Ambulance'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(c)=>const MySplashScreenALS()));
                  },
                  child: Text('BOOK MUHAFFIZ FOR ADVANCE LIFE SUPPORT'),

                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(c)=>const MySplashScreen()));
                  },
                  child: Text('BOOK MUHAFFIZ FOR BASIC LIFE SUPPORT'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(c)=>const MySplashScreenPatientTransfer()));
                  },
                  child: Text('BOOK MUHAFFIZ FOR PATIENT TRANSFER'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
