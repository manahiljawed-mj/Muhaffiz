import 'package:flutter/cupertino.dart';
import 'package:muhaffiz_user/models/directions.dart';

import '../global/global.dart';
import '../models/TripsHistoryModel.dart';

class AppInfo extends ChangeNotifier
{
  Directions? userPickUpLocation, userDropOffLocation;
  Directions? alsd;
  int countTotalTrips = 0;
  List<String> historyTripsKeysList = [];
  List<TripsHistoryModel> allTripsHistoryInformationList = [];


  void als_dest(Directions alsd) {
    alsd=dest as Directions;
    notifyListeners();
  }


  void updatePickUpLocationAddress(Directions userPickUpAddress)
  {
    userPickUpLocation = userPickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Directions dropOffAddress)
  {
    userDropOffLocation = dropOffAddress;
    notifyListeners();
  }
  updateOverAllTripsCounter(int overAllTripsCounter)
  {
    countTotalTrips = overAllTripsCounter;
    notifyListeners();
  }

  updateOverAllTripsKeys(List<String> tripsKeysList)
  {
    historyTripsKeysList = tripsKeysList;
    notifyListeners();
  }

  updateOverAllTripsHistoryInformation(TripsHistoryModel eachTripHistory)
  {
    allTripsHistoryInformationList.add(eachTripHistory);
    notifyListeners();
  }
}