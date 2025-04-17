import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import '../mainScreens/main_als.dart';
import '../models/direction_details_info.dart';
import '../models/user_model.dart';



final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //online-active drivers Information List
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId="";
String cloudMessagingServerToken = "key=AAAAIeblQ5g:APA91bF6phgMHg_UxyhxGWrxmehWE2vAAMu64ch1DRiTUSiJXU2QOkJ4MWgujcfAHUJ99fVcccpYQgGq_xtlWJYbjfPgLk-fXxdUZIXzsvJxNKim2gDrb-6iM4H7lKikCGnCzt2XbO8Q";
String userDropOffAddress = "";
String driverCarDetails="";
String driverName="";
String driverPhone="";
double countRatingStars=0.0;
String titleStarsRating="";
List<Hospital> _hospitals = [];
Destination? _destinationPosition;
Destination? dest;
class Hospital {
  final String name;
  final double latitude;
  final double longitude;
  double trafficScore;
  Duration? travelTime;
  Hospital({required this.name, required this.latitude, required this.longitude, this.trafficScore = 0, this.travelTime});
}
Position? destinationloc;