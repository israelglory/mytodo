import 'package:flutter/material.dart';

import '../cores.dart';

class OrWidgetView extends StatelessWidget {
  const OrWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color greycolor = Colors.grey.shade400;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppRectangle(
          radius: 100,
          color: greycolor,
          height: 8,
          width: 8,
        ),
        AppRectangle(
          width: 100,
          height: 1,
          color: greycolor,
        ),
        SizedBox(width: 10),
        AppText("Or"),
        SizedBox(width: 10),
        AppRectangle(
          width: 100,
          height: 1,
          color: greycolor,
        ),
        AppRectangle(
          radius: 100,
          color: greycolor,
          height: 8,
          width: 8,
        ),
      ],
    );
  }
}
