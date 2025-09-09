import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import '../../core/cores.dart';
import 'splash_screen_vm.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) {
        viewModel.initializeSplashScreen();
      },
      viewModelBuilder: () => SplashScreenVM(),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: AppRectangle(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.logoPNG,
                  width: 130.h,
                  height: 130.w,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
