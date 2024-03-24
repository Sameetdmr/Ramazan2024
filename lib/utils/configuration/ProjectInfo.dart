// ignore_for_file: prefer_constructors_over_static_methods

import 'package:get/get.dart';
import 'package:ramadan/model/home/GridItem.dart';

final class ProjectInfo {
  ProjectInfo._init();
  static ProjectInfo? _instance;

  static ProjectInfo get instance {
    return _instance ??= ProjectInfo._init();
  }

  RxList<RxBool> isActiveList = <RxBool>[].obs;
  RxList<GridItem> gridItemList = <GridItem>[].obs;
  RxString cityName = ''.obs;
}
