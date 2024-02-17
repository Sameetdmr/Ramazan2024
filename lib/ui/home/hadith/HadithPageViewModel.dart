import 'package:get/get.dart';
import 'package:ramadan/model/domain/HadithModel.dart';
import 'package:ramadan/services/home/HadithService.dart';
import 'package:ramadan/ui/ViewModelBase.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/servicelocator/ServiceLocator.dart';

class HadithPageViewModel extends ViewModelBase {
  RxBool isLoading = false.obs;
  RxString categoryName = ''.obs;

  RxList<HadithModel> hadithList = <HadithModel>[].obs;
  RxList<String> uniqueCategoryList = <String>[].obs;
  IHadithService _iHadithService = ServiceLocator().get<IHadithService>();

  HadithPageViewModel() {
    setCurrentScreen('Hadith Page');
  }

  @override
  void onInit() async {
    try {
      await fillHadithList();
    } catch (e) {
      exceptionHandlingService.handleException(e);
    }
    super.onInit();
  }

  Future<void> fillHadithList() async {
    hadithList.value = await _iHadithService.loadHadiths();
    if (hadithList.isNotEmpty) {
      fillHadithCategoryList();
      isLoading.value = true;
    }
  }

  void fillHadithCategoryList() {
    Set<String> uniqueCategorySet = hadithList.map((element) => element.category).toSet();
    // Set kullanmanın avantajlarından biri, otomatik olarak benzersiz elemanları içermesidir
    uniqueCategoryList.add(StringHadithConstant.allCategory);
    uniqueCategoryList.addAll(uniqueCategorySet.toList());
  }

  Future<List<HadithModel>> getHadithsByCategory(String category) async {
    hadithList.value = await _iHadithService.loadHadiths();
    if (category == StringHadithConstant.allCategory) {
      categoryName.value = '';
      hadithList = hadithList;
    } else {
      categoryName.value = category;
      hadithList.value = hadithList.where((hadith) => hadith.category == category).toList();
    }
    hadithList.refresh();
    return hadithList;
  }
}
