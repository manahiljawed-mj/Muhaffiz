import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muhaffiz_driver/models/driver_data.dart';
import 'package:muhaffiz_driver/models/user_model.dart';

final FirebaseAuth fAuth=FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
StreamSubscription<Position>? streamSubscriptionPosition;
StreamSubscription<Position>? streamSubscriptionDriverLivePosition;
Position? driverCurrentPosition;
AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
DriverData onlineDriverData=DriverData();
String? driverVehicleType = "";
String titleStarsRating = "Good";
bool isDriverActive = false;
String statusText = "Now Offline";
Color buttonColor = Colors.grey;
