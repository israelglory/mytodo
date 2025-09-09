import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../cores.dart';

class BottomSheetService {
  /// Generic reactive sheet that rebuilds from a Stacked ViewModel.
  Future<T?> showReactive<T, VM extends BaseViewModel>({
    required VM Function() viewModelBuilder,
    required Widget Function(BuildContext context, VM model) builder,
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? barrierColor,
  }) {
    final ctx = navigationService.navigatorKey.currentState!.context;

    return showModalBottomSheet<T>(
      context: ctx,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      barrierColor: barrierColor ?? Colors.black.withOpacity(0.45),
      backgroundColor: Colors.transparent,
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ViewModelBuilder<VM>.reactive(
              viewModelBuilder: viewModelBuilder,
              disposeViewModel: false,
              builder: (ctx, model, _) => Material(
                elevation: 8,
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                child: builder(ctx, model),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<T?> show<T>(
    Widget child, {
    bool isScrollControlled = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? barrierColor,
  }) {
    final ctx = navigationService.navigatorKey.currentState!.context;
    return showModalBottomSheet<T>(
      context: ctx,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      // ✅ dim like the mock
      barrierColor: barrierColor ?? Colors.black.withOpacity(0.45),
      // ✅ let our own container draw rounded corners & shadow
      backgroundColor: Colors.transparent,
      builder: (context) {
        final media = MediaQuery.of(context);
        return SafeArea(
          child: Padding(
            // keep it a bit off the screen edge for the “floating” feel
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: media.viewInsets.bottom + 16,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  // height similar to your mock (adjust as you like)
                  maxHeight: media.size.height * 0.5,
                  minWidth: double.infinity,
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }

  static void dismiss() =>
      Navigator.of(navigationService.navigatorKey.currentState!.context).pop();
}
