import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OverlayLoaderWidget extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const OverlayLoaderWidget(
      {super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(.6),
            child: Center(
              child: LoadingAnimationWidget.bouncingBall(
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
      ],
    );
  }
}
