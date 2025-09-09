import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mytodo/core/cores.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mytodo/core/widgets/app_rectangle.dart';

class HomeCalendarTile extends StatefulWidget {
  final Function(DateTime selectedDay)? onDaySelected;
  final Function(DateTime focusedDay)? onMonthChanged;

  const HomeCalendarTile({
    super.key,
    this.onDaySelected,
    this.onMonthChanged,
  });

  @override
  State<HomeCalendarTile> createState() => _HomeCalendarTileState();
}

class _HomeCalendarTileState extends State<HomeCalendarTile> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<String> _months = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final List<int> _years = List.generate(30, (i) => 2020 + i);

  int get _selectedMonth => _focusedDay.month;
  int get _selectedYear => _focusedDay.year;

  void _showMonthYearPicker() {
    int tempMonth = _selectedMonth;
    int tempYear = _selectedYear;

    bottomSheetService.show(
      Container(
        height: 300.h,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 200.h,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: tempMonth - 1,
                      ),
                      itemExtent: 40,
                      onSelectedItemChanged: (index) {
                        tempMonth = index + 1;
                      },
                      children: _months
                          .map((m) => Center(child: Text(m)))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: _years.indexOf(tempYear),
                      ),
                      itemExtent: 40,
                      onSelectedItemChanged: (index) {
                        tempYear = _years[index];
                      },
                      children: _years
                          .map((y) => Center(child: Text(y.toString())))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CupertinoButton(
              child: const Text("Done"),
              onPressed: () {
                navigationService.pop();
                setState(() {
                  _focusedDay = DateTime(tempYear, tempMonth, 1);
                  widget.onMonthChanged?.call(_focusedDay);
                });
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppRectangle(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      borderColor: AppColors.appGrey,
      borderWidth: 1,
      radius: 16,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: _showMonthYearPicker,
                child: Row(
                  children: [
                    Text(
                      '${_months[_selectedMonth - 1]} $_selectedYear',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              Row(
                children: [
                  AppRectangle(
                    radius: 100,
                    borderWidth: 1,
                    borderColor: Colors.black12,
                    onTap: () {
                      setState(() {
                        _focusedDay = DateTime(
                          _focusedDay.year,
                          _focusedDay.month - 1,
                        );
                        widget.onMonthChanged?.call(_focusedDay);
                      });
                    },
                    child: const Icon(Icons.chevron_left),
                  ),
                  const SizedBox(width: 16),
                  AppRectangle(
                    radius: 100,
                    borderWidth: 1,
                    borderColor: Colors.black12,
                    onTap: () {
                      setState(() {
                        _focusedDay = DateTime(
                          _focusedDay.year,
                          _focusedDay.month + 1,
                        );
                        widget.onMonthChanged?.call(_focusedDay);
                      });
                    },
                    child: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2050),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerVisible: false,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              widget.onDaySelected?.call(selectedDay);
            },
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              defaultTextStyle: const TextStyle(color: Colors.black),
              weekendTextStyle: const TextStyle(color: Colors.black),
              selectedDecoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontWeight: FontWeight.w500),
              weekendStyle: TextStyle(fontWeight: FontWeight.w500),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) => Center(
                child: AppRectangle(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  radius: 100,
                  color: Colors.white,
                  borderColor: AppColors.greyBuutton,
                  child: AppText('${day.day}'),
                ),
              ),
              todayBuilder: (context, day, _) => Center(
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: AppText(
                    '${day.day}',
                    color: Colors.white,
                  ),
                ),
              ),
              selectedBuilder: (context, day, _) => Center(
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor,
                  ),
                  child: AppText(
                    '${day.day}',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
