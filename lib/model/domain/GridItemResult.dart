import 'package:get/get.dart';
import 'package:ramadan/model/home/GridItem.dart';

class GridItemResult {
  RxList<GridItem> gridItemList;
  RxList<RxBool> isActiveList;

  GridItemResult(this.gridItemList, this.isActiveList);
}
