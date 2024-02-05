import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';

abstract class ILocationService {
  Future<String> getCityNameFromCoordinates();
}

class LocationService implements ILocationService {
  @override
  Future<String> getCityNameFromCoordinates() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        String cityName = placemarks.first.administrativeArea ?? "";
        return cityName.toUpperCase();
      }
    } catch (e) {
      throw CustomException(StringHomeConstant.coordinateError);
    }
    return "";
  }
}
