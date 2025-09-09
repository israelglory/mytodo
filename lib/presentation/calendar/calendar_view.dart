import 'package:flutter/material.dart';
import 'package:mytodo/core/widgets/app_text.dart';
import 'package:mytodo/presentation/calendar/calendar_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../core/widgets/calendar_tile.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalendarViewModel>.reactive(
      viewModelBuilder: () => CalendarViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                ),
                AppText(
                  "My Calendar",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 24,
                ),

                HomeCalendarTile(
                  onDaySelected: (selectedDay) {},
                  onMonthChanged: (focusedDay) {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
