// core/functions/adhan.dart
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AdhanService {
 static  String? _currentAddress;
 static   Position? _currentPostion;
   Position? get currentPostion => _currentPostion;


 static Future<bool> _handleLocationPersmission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log('Please enable Location service');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      log("'Location service is denied'");
      return false;
    }
    return true;
  }

  static Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPersmission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPostion = position;
      _getAddressFromLatLng(_currentPostion!);
    }).catchError((e) {
      print(e);
    });
  }

  static Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPostion!.latitude, _currentPostion!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      _currentAddress = '${place.street} '
          ',${place.subLocality} ,${place.country}  ,${place.postalCode} ';
    }).catchError((e) {
      print(e);
    });
  }
}
