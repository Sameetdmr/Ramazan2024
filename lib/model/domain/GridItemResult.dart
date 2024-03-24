import 'package:get/get.dart';
import 'package:ramadan/model/home/GridItem.dart';

final class GridItemResult {
  GridItemResult(this.gridItemList, this.isActiveList);
  final RxList<GridItem> gridItemList;
  final RxList<RxBool> isActiveList;
}
