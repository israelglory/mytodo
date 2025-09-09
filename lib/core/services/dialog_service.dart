import 'package:flutter/material.dart';

import '../cores.dart';

class DialogService {
  void showCustomDialog({Widget? child}) async {
    return await showDialog(
      useSafeArea: true,
      context: navigationService.navigatorKey.currentState!.context,
      barrierDismissible: true,
      builder: (c) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        scrollable: false,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        content: child,
      ),
    );
  }

  Future<bool?> showYesOrNo(
      {required String message, String? title, Function()? onConfirm}) async {
    return await showDialog(
        useSafeArea: true,
        context: navigationService.navigatorKey.currentState!.context,
        barrierDismissible: true,
        builder: (c) => SizedBox(
              width: 56,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                scrollable: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title != null)
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: AppText(title,
                                alignment: TextAlign.left,
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    // SizedBox(
                    //     height: MediaQuery.of(navigationService
                    //                 .navigatorKey.currentState!.context)
                    //             .size
                    //             .width *
                    //         0.04),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: AppText(message,
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                            onTap: () => navigationService.pop(),
                            behavior: HitTestBehavior.opaque,
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: AppText('Cancel',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )),
                        SizedBox(
                            width: MediaQuery.of(navigationService
                                        .navigatorKey.currentState!.context)
                                    .size
                                    .width *
                                0.05),
                        GestureDetector(
                            onTap: onConfirm,
                            behavior: HitTestBehavior.opaque,
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: AppText(
                                'Yes',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  void dismiss() =>
      Navigator.of(navigationService.navigatorKey.currentState!.context).pop();
}
