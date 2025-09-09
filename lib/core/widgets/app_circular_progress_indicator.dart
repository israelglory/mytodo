import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  const AppCircularProgressIndicator({super.key, this.size, this.color});
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return size == null
        ? Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: color ?? AppColors.primaryColor,
            ),
          )
        : Center(
            child: SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: color ?? AppColors.primaryColor,
              ),
            ),
          );
  }
}
