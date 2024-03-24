// ignore_for_file: one_member_abstracts

import 'dart:async';
import 'package:ramadan/model/domain/PrayerTimeDetails.dart';
import 'package:ramadan/model/domain/PrayerTimesModel.dart';
import 'package:ramadan/rest/RestServiceManager.dart';
import 'package:ramadan/services/common/core/ConfigurationService.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

abstract class IRamadanDataProvider {
  Future<PrayerTimesModel> loadRamadanData({required String cityName, String? date});
}

final class RamadanDataProvider implements IRamadanDataProvider {
  RamadanDataProvider() {
    final configurationService = ServiceLocator().get<IConfigurationService>();
    _apiUrl = configurationService.getApiServiceURL();
  }
  late String _apiUrl;

  @override
  Future<PrayerTimesModel> loadRamadanData({required String cityName, String? date}) async {
    try {
      final lowercaseUserCityChoiceString = cityName.toLowerCase();
      final rawData = await RestServiceManager.call(_apiUrl, lowercaseUserCityChoiceString, null);
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
    final prayerTimeDetailsList = <PrayerTimeDetails>[];

    for (var i = 0; i < rawData.length / 8; i++) {
      final currentRawDate = rawData[8 * i + 1];

      if (currentRawDate.contains(date)) {
        final times = rawData.sublist(8 * i + 2, 8 * i + 8);

        // Date formatını düzenle
        final dateParts = currentRawDate.split(' ');
        final formattedDate = '${dateParts[0]} ${dateParts[1]}, ${dateParts[2]}';

        // times listesini map'e ekle
        prayerTimeDetailsList.add(PrayerTimeDetails(date: formattedDate, times: times));
      }
    }

    return PrayerTimesModel(cityName: cityName, region: cityName, times: prayerTimeDetailsList);
  }

  PrayerTimesModel _convertData(List<String> rawData, String cityName) {
    final prayerTimeDetailsList = <PrayerTimeDetails>[];

    for (var i = 0; i < rawData.length / 8; i++) {
      final date = rawData[8 * i + 1];
      final times = rawData.sublist(8 * i + 2, 8 * i + 8);

      // Date formatını düzenle
      final dateParts = date.split(' ');
      final formattedDate = '${dateParts[0]} ${dateParts[1]}, ${dateParts[2]}';

      // times listesini map'e ekle
      prayerTimeDetailsList.add(PrayerTimeDetails(date: formattedDate, times: times));
    }

    return PrayerTimesModel(cityName: cityName, region: cityName, times: prayerTimeDetailsList);
  }
}
