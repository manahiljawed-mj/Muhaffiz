import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AboutScreen extends StatefulWidget
{
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}




class _AboutScreenState extends State<AboutScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(

        children: [

          //image
          Container(
            height: 230,
            child: Center(
              child: Image.asset(
                "images/Basic Life Support.png",
                width: 260,
              ),
            ),
          ),

          Column(
            children: [

              //company name
              const Text(
                "Muhaffiz User Application",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //about you & your company - write some info
              const Text(
                "First Ambulance Booking  Application with ALS, BLS, AND PT Modules\n "
                    "Targets the Health Care Sector\n"
                    "\nSupervised By:\n"
                     "Anaum Hamid",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "Developed By:\n"
                "K190210-Manahil Jawed\n "
                    "K190201 Abdul Hanan\n"
                    "K190222 Rameen Rizwan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              //close
              ElevatedButton(
                onPressed: ()
                {
                  SystemNavigator.pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white54,
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                ),
              ),

            ],
          ),

        ],

      ),
    );
  }
}
