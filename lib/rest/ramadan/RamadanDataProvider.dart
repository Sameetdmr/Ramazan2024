import 'dart:async';
import 'package:ramadan/model/domain/PrayerTimeDetails.dart';
import 'package:ramadan/model/domain/PrayerTimesModel.dart';
import 'package:ramadan/rest/RestServiceManager.dart';
import 'package:ramadan/services/common/core/ConfigurationService.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

abstract class IRamadanDataProvider {
  Future<PrayerTimesModel> loadRamadanData(String cityName, String? date);
}

class RamadanDataProvider implements IRamadanDataProvider {
  late String _apiUrl;

  RamadanDataProvider() {
    IConfigurationService configurationService = ServiceLocator().get<IConfigurationService>();
    _apiUrl = configurationService.getApiServiceURL();
  }

  @override
  Future<PrayerTimesModel> loadRamadanData(String cityName, String? date) async {
    try {
      String lowercaseUserCityChoiceString = cityName.toLowerCase();
      List<String> rawData = await RestServiceManager.call(_apiUrl, lowercaseUserCityChoiceString, null);
      if (date != null) {
        return _convertDataForDate(rawData, cityName, date);
      } else {
        return _convertData(rawData, cityName);
      }
    } catch (e) {
      throw CustomException(StringHomeConstant.prayerTimesError);
    }
  }

  PrayerTimesModel _convertDataForDate(List<String> rawData, String cityName, String date) {
    List<PrayerTimeDetails> prayerTimeDetailsList = [];

    for (int i = 0; i < rawData.length / 8; i++) {
      String currentRawDate = rawData[8 * i + 1];

      if (currentRawDate.contains(date)) {
        List<String> times = rawData.sublist(8 * i + 2, 8 * i + 8);

        // Date formatını düzenle
        List<String> dateParts = currentRawDate.split(' ');
        String formattedDate = '${dateParts[0]} ${dateParts[1]}, ${dateParts[2]}';

        // times listesini map'e ekle
        prayerTimeDetailsList.add(PrayerTimeDetails(date: formattedDate, times: times));
      }
    }

    return PrayerTimesModel(cityName: cityName, region: cityName, times: prayerTimeDetailsList);
  }

  PrayerTimesModel _convertData(List<String> rawData, String cityName) {
    List<PrayerTimeDetails> prayerTimeDetailsList = [];

    for (int i = 0; i < rawData.length / 8; i++) {
      String date = rawData[8 * i + 1];
      List<String> times = rawData.sublist(8 * i + 2, 8 * i + 8);

      // Date formatını düzenle
      List<String> dateParts = date.split(' ');
      String formattedDate = '${dateParts[0]} ${dateParts[1]}, ${dateParts[2]}';

      // times listesini map'e ekle
      prayerTimeDetailsList.add(PrayerTimeDetails(date: formattedDate, times: times));
    }

    return PrayerTimesModel(cityName: cityName, region: cityName, times: prayerTimeDetailsList);
  }
}
