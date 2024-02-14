import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';

class PermissionManager {
  static Future<bool> checkLocationPermission() async {
    try {
      LocationPermission permission;

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
          return true;
        } else if (permission == LocationPermission.deniedForever) {
          Geolocator.openAppSettings();
          return false;
        }
      } else if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        return true;
      }

      return false;
    } catch (e) {
      throw CustomException(StringCommonConstant.checkLocationPermissionError);
    }
  }

  static Future<Position?> getCurrentLocation() async {
    try {
      bool hasPermission = await checkLocationPermission();

      if (hasPermission) {
        return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      } else {
        return null;
      }
    } catch (e) {
      throw CustomException(StringCommonConstant.getCurrentLocationError);
    }
  }

  static Future<bool> checkAndRequestNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();

    if (status == PermissionStatus.granted) {
      // Kullanıcı zaten izin verdi.
      return true;
    } else {
      // Kullanıcı izin vermedi, izin talep et.
      PermissionStatus requestedStatus = await Permission.notification.request();

      // Kullanıcı izin verdiyse true döner, aksi takdirde false döner.
      return requestedStatus == PermissionStatus.granted;
    }
  }
}
