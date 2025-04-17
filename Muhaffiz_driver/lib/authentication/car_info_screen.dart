import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muhaffiz_driver/authentication/login_screen.dart';
import 'package:muhaffiz_driver/global/global.dart';
import 'package:muhaffiz_driver/mainScreens/main_screen.dart';
import 'package:muhaffiz_driver/splashScreen/splash_screen.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}




class _CarInfoScreenState extends State<CarInfoScreen> {

  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();
  List<String> carTypesList=["Advance Life Support","Basic Life Support","Patient Transfer"];
  String? selectedCarType;
  
  saveCarInfo()
  {
    Map driverCarInfoMap = {
      "car_color":carColorTextEditingController.text.trim(),
      "car_number":carNumberTextEditingController.text.trim(),
      "car_model":carModelTextEditingController.text.trim(),
      "type":selectedCarType,
    };


    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    driversRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);
    
    Fluttertoast.showToast(msg: "Car Detail Have Been Saved");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
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
              const SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/muhaffiz_driver_auth.png"),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Enter Vehicle Details",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: carModelTextEditingController,
                keyboardType: TextInputType.text,
                style:const TextStyle(
                    color: Colors.white

                ),
                decoration:const InputDecoration(
                  labelText: "Car Model",
                  hintText: "Suzuki Bolan 2006",

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
                controller: carNumberTextEditingController,
                keyboardType: TextInputType.text,
                style:const TextStyle(
                    color: Colors.white

                ),
                decoration:const InputDecoration(
                  labelText: "Car Number",
                  hintText: "ABC456",

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
                controller: carColorTextEditingController,
                keyboardType: TextInputType.text,
                style:const TextStyle(
                    color: Colors.white

                ),
                decoration:const InputDecoration(
                  labelText: "Car Color",
                  hintText: "Blue",

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


              const SizedBox(height: 60,),

              DropdownButton(
                dropdownColor: Colors.white,
                hint: const Text(
                  "Please Choose Ambulance Type",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,

                  ),
                ),
                value: selectedCarType,
                onChanged: (newValue)
                {
                  setState(() {
                    selectedCarType=newValue.toString();
                  });
                },
                items: carTypesList.map((car){
                  return DropdownMenuItem(
                    child:Text(
                      car,
                      style: const TextStyle(color: Colors.blue),
                    ),
                    value: car,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: ()
                {
                  if(carModelTextEditingController.text.isNotEmpty 
                      && carNumberTextEditingController.text.isNotEmpty 
                      && carColorTextEditingController.text.isNotEmpty && selectedCarType !=null){
                    saveCarInfo();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child:const Text(
                  "Save Information",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
