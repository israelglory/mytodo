import 'package:flutter/material.dart';
import 'package:mytodo/core/cores.dart';

class CompletedPageView extends StatelessWidget {
  final bool isCompleted;
  final String? title;
  final String? message;
  final String? buttonText;
  final Function()? onButtonPressed;
  const CompletedPageView({
    super.key,
    required this.isCompleted,
    this.title,
    this.message,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,

      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppRectangle(
                          color: AppColors.secondaryColor,
                          padding: const EdgeInsets.all(40),
                          radius: 100,
                          child: Icon(
                            isCompleted ? Icons.check : Icons.error,
                            color: Colors.white,
                            size: 100,
                          ),
                        ),
                        const SizedBox(height: 20),
                        AppText(
                          title ?? '',
                          fontSize: 24,
                          alignment: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        AppText(
                          message ?? '',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          alignment: TextAlign.center,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                AppButton(
                  onPressed: onButtonPressed,
                  color: Colors.white,
                  child: AppText(
                    buttonText ?? 'Continue',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 34),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
