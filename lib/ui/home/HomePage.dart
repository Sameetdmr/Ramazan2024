import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/ui/home/HomePageViewModel.dart';

class HomePage extends StatelessWidget {
  late HomePageViewModel _homePageViewModel;
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _homePageViewModel = Get.put(HomePageViewModel());
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
        actions: [
          Obx(
            () => Visibility(
                visible: _homePageViewModel.isLoggedIn.value,
                child: IconButton(
                    onPressed: () async {
                      await _homePageViewModel.signOut(context);
                    },
                    icon: Icon(Icons.exit_to_app_outlined))),
          )
        ],
      ),
    );
  }
}
