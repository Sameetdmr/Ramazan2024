// ignore_for_file: one_member_abstracts

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';

abstract class ILocationService {
  Future<String> getCityNameFromCoordinates();
}

final class LocationService implements ILocationService {
  @override
  Future<String> getCityNameFromCoordinates() async {
    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final cityName = placemarks.first.administrativeArea ?? '';
        return cityName.toUpperCase();
      }
    } catch (e) {
      throw CustomException(StringHomeConstant.coordinateError);
    }
    return '';
  }
}
