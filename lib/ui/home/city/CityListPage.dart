import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';

class CityListPage extends StatelessWidget {
  const CityListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              CustomNavigator().popFromMain(null);
            },
          ),
          elevation: 0,
          title: Text(
            'Şehir Seçiniz',
            style: context.textTheme.bodyMedium?.copyWith(color: ColorTextConstant.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: context.padding.low,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  CustomNavigator().popFromMain(0);
                },
                child: ListTile(
                  title: Text('Tam konumu kullan', style: context.textTheme.bodyMedium?.copyWith(color: Colors.orange)),
                  trailing: Icon(
                    Icons.location_on_outlined,
                    color: Colors.orange,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.black,
                    );
                  },
                  itemCount: StringCityConstant.turkeyCities.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        CustomNavigator().popFromMain(index);
                      },
                      child: ListTile(
                        title: Text(
                          StringCityConstant.turkeyCities[index],
                          style: context.textTheme.labelMedium,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
