// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'package:ramadan/model/domain/TurkeyCity.dart';
import 'package:ramadan/utils/constants/color_constant.dart';
import 'package:ramadan/utils/constants/string_constant.dart';
import 'package:ramadan/utils/navigation/CustomNavigator.dart';
import 'package:ramadan/utils/theme/CustomTextTheme.dart';

class CityListPage extends StatelessWidget {
  List<TurkeyCity> turkeyCities;
  CityListPage({
    required this.turkeyCities,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorCommonConstant.white,
        appBar: AppBar(
          centerTitle: false,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))],
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: ColorCommonConstant.black,
            ),
            onPressed: () {
              CustomNavigator().popFromMain();
            },
          ),
          elevation: 0,
          title: Text(
            'Şehir Seçiniz',
            style: CustomTextTheme(context).bodyMedium.copyWith(color: ColorTextConstant.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: ColorCommonConstant.transparent,
        ),
        body: Padding(
          padding: context.padding.low,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  CustomNavigator().popFromMain();
                },
                child: ListTile(
                  title: Text(StringHomeConstant.usePreciseLocation, style: CustomTextTheme(context).bodyMedium.copyWith(color: ColorTextConstant.orangeAccent)),
                  trailing: Icon(
                    Icons.location_on_outlined,
                    color: ColorTextConstant.orangeAccent,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: ColorCommonConstant.black,
                    );
                  },
                  itemCount: turkeyCities.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        CustomNavigator().popFromMain(index);
                      },
                      child: ListTile(
                        title: Text(
                          turkeyCities[index].name,
                          style: CustomTextTheme(context).labelMedium,
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_outlined,
                          color: ColorCommonConstant.black,
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
