import 'package:flutter/material.dart';
import 'package:muhaffiz_user/mainScreens/main_als.dart';
import 'package:muhaffiz_user/mainScreens/main_cardio_als.dart';
import 'package:muhaffiz_user/mainScreens/main_neuro_als.dart';
import 'package:muhaffiz_user/splashScreen/splash_screen.dart';
import 'package:muhaffiz_user/splashScreen/splash_screen_als.dart';
import 'package:muhaffiz_user/splashScreen/splash_screen_patient_tranfer.dart';

class ALS extends StatefulWidget {
  const ALS({Key? key}) : super(key: key);
  @override
  State<ALS> createState() => _ALS();
}

class _ALS extends State<ALS> {
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
                  child: Text('SELECT TYPE OF EMERGENCY'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(c)=>CardioALS()));
                  },
                  child: Text('EMERGENCY RELATED TO CARDIOLOGY'),

                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(c)=> NeuroALS()));
                  },
                  child: Text('EMERGENCY RELATED TO NEUROLOGY'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(c)=>HospitalListScreen()));
                  },
                  child: Text('OTHER EMERGENCIES'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
