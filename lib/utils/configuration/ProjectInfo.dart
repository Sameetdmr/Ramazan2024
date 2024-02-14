import 'package:get/get.dart';
import 'package:ramadan/model/home/GridItem.dart';

class ProjectInfo {
  static ProjectInfo? _instance;

  static ProjectInfo get instance {
    return _instance ??= ProjectInfo._init();
  }

  ProjectInfo._init();

  RxList<RxBool> isActiveList = <RxBool>[].obs;
  RxList<GridItem> gridItemList = <GridItem>[].obs;
  RxString cityName = ''.obs;
}
