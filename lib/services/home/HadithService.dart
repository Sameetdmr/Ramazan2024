import 'dart:convert';

import 'package:ramadan/model/domain/HadithModel.dart';
import 'package:flutter/services.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';

abstract class IHadithService {
  Future<List<HadithModel>> loadHadiths();
}

class HadithService implements IHadithService {
  @override
  Future<List<HadithModel>> loadHadiths() async {
    try {
      String jsonString = await rootBundle.loadString(ProjectConstant.hadithJsonPath);
      List<dynamic> jsonList = json.decode(jsonString);

      List<HadithModel> hadithList = jsonList.map((item) => HadithModel.fromJson(item)).toList();
      return hadithList;
    } catch (e) {
      throw CustomException(StringCommonConstant.anErrorHadithService);
    }
  }
}
