import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:muhaffiz_user/global/global.dart';
import 'package:muhaffiz_user/mainScreens/main_screen.dart';
import 'dart:convert';

import 'package:muhaffiz_user/mainScreens/main_screen_als_final.dart';


class Destination {
  final double latitude;
  final double longitude;

  Destination({required this.latitude, required this.longitude});
}

class NeuroALS extends StatefulWidget {
  @override
  _NeuroALS createState() => _NeuroALS();
}

class _NeuroALS extends State<NeuroALS> {
  Position? _currentPosition;
  List<Hospital> _hospitals = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
    _getNearbyHospitals();
  }

  Future<void> _getNearbyHospitals() async {
    String apiKey = 'AIzaSyCjYbqJfSiVxFTWL3NQ8VA8ca9LgN5trQ4';
    String trafficApiUrl = 'YOUR_TRAFFIC_API_URL';
    double radius = 5000; // 5km
    String type = 'hospital';
    String keyword = 'neuro';

    if (_currentPosition != null) {
      String location =
          '${_currentPosition!.latitude},${_currentPosition!.longitude}';
      String url =
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$location&radius=$radius&type=$type&keyword=$keyword&key=$apiKey';
      //'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$location&radius=$radius&type=$type&key=$apiKey';

      var response = await http.get(Uri.parse(url));
      var data = json.decode(response.body);

      List<Hospital> hospitals = [];

      for (var result in data['results']) {
        String name = result['name'];
        double latitude = result['geometry']['location']['lat'];
        double longitude = result['geometry']['location']['lng'];

        Hospital hospital = Hospital(
          name: name,
          latitude: latitude,
          longitude: longitude,
        );
        hospitals.add(hospital);
      }

      // Fetch traffic data for each hospital
      for (Hospital hospital in hospitals) {
        double trafficScore = await _fetchTrafficScore(hospital.latitude, hospital.longitude);
        hospital.trafficScore = trafficScore;

        double distanceInMeters = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          hospital.latitude,
          hospital.longitude,
        );
        double distanceInKm = distanceInMeters / 1000;
        double travelTimeInMinutes = distanceInKm / 50; // Assuming average speed of 50 km/h
        hospital.travelTime = Duration(minutes: travelTimeInMinutes.toInt());
      }



      hospitals.sort((a, b) {
        // Sort by the combined score of distance and traffic
        double scoreA = a.trafficScore + _calculateDistance(a.latitude, a.longitude);
        double scoreB = b.trafficScore + _calculateDistance(b.latitude, b.longitude);
        return scoreA.compareTo(scoreB);
      });

      setState(() {
        _hospitals = hospitals.take(5).toList();
      });
    }
  }

  Future<double> _fetchTrafficScore(double latitude, double longitude) async {
    // Fetch real-time traffic data from the traffic service API
    // Use the latitude and longitude of the hospital to get traffic information
    // Parse the response and calculate a traffic score based on your criteria
    // Return the traffic score
    return 0; // Placeholder value
  }


  Destination? _destinationLocation; // Rename the variable to Destination

  // ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearest Hospitals'),
      ),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _hospitals.length,
        itemBuilder: (BuildContext context, int index) {
          Hospital hospital = _hospitals[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  // Set the selected hospital's location as the destination
                  _destinationLocation = Destination(
                    latitude: hospital.latitude,
                    longitude: hospital.longitude,
                  );
                });
                Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.all(16.0),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      hospital.name,
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Distance: ${_calculateDistance(hospital.latitude, hospital.longitude)} km',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    //Text('Travel Time: ${hospital.travelTime?.inMinutes ?? 'N/A'} minutes'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ...
  double _calculateDistance(double latitude, double longitude) {
    double distanceInMeters = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        latitude,
        longitude);
    double distanceInKm = distanceInMeters / 1000;
    return double.parse(distanceInKm.toStringAsFixed(2));
  }
}

void main() {
  runApp(MaterialApp(
    home: NeuroALS(),
  ));
}
