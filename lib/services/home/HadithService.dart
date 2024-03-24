// ignore_for_file: lines_longer_than_80_chars, prefer_final_locals, one_member_abstracts

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ramadan/model/domain/HadithModel.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/exceptions/CustomException.dart';

abstract class IHadithService {
  Future<List<HadithModel>> loadHadiths();
}

final class HadithService implements IHadithService {
  @override
  Future<List<HadithModel>> loadHadiths() async {
    try {
      var jsonString = await rootBundle.loadString(ProjectConstant.hadithJsonPath);
      dynamic decodedJson = json.decode(jsonString);

      var jsonList = decodedJson as List<dynamic>;

      var hadithList = jsonList.map((item) => HadithModel.fromJson(item as Map<String, dynamic>)).toList();
      return hadithList;
    } catch (e) {
      throw CustomException(StringCommonConstant.anErrorHadithService);
    }
  }
}
