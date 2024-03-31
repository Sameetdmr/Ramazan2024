import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan/model/home/GridItem.dart';
import 'package:ramadan/utils/theme/CustomTextTheme.dart';

class GridCard extends StatelessWidget {
  const GridCard(this.item, {super.key});
  final GridItem item;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: item.isActive.value ? BorderSide(color: item.color, width: 2) : BorderSide.none,
        ),
        color: item.isActive.value ? item.color.withOpacity(0.5) : item.color.withOpacity(0.1),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Align(alignment: Alignment.topLeft, child: Text(item.title, style: CustomTextTheme(context).bodyMedium.copyWith(fontWeight: FontWeight.bold))),
                const Spacer(),
                Flexible(
                  flex: 20,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      item.iconPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Align(alignment: Alignment.bottomLeft, child: Text(item.time, style: CustomTextTheme(context).titleMedium.copyWith())),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
