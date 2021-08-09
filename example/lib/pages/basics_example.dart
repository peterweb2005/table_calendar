// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

class TableBasicsExample extends StatefulWidget {
  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  //
  final log = Logger('BasicsExample');

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Basics'),
      ),
      body: TableCalendar(
        //
        locale: 'zh_HK',
        calendarBuilders: CalendarBuilders(
          /// Signature for a function that creates a single event marker for a given `day`.
          /// Contains a single `event` associated with that `day`.
          singleMarkerBuilder: (context, day, event) {
            log.fine('singleMarkerBuilder()');
            //
            final shorterSide = 20;
            final calendarStyle = const CalendarStyle();
            final markerSize = calendarStyle.markerSize ??
                (shorterSide - calendarStyle.cellMargin.vertical) *
                    calendarStyle.markerSizeScale;
            //
            return Container(
              width: markerSize,
              height: markerSize,
              margin: calendarStyle.markerMargin,
              decoration: calendarStyle.markerDecoration,
            );
            //
            return Text(event.toString());
          },

          /// Signature for a function that creates an event marker for a given `day`.
          /// Contains a list of `events` associated with that `day`.
          markerBuilder: (context, day, events) {
            log.fine('markerBuilder()');
            return Text(events.length.toString());
          },
          selectedBuilder: (context, day, focusedDay) {
            log.fine('selectedBuilder()');
            //
            final calendarStyle = const CalendarStyle();
            //
            final text = '${day.day}';
            final margin = calendarStyle.cellMargin;
            final duration = const Duration(milliseconds: 1000);
            //
            return AnimatedContainer(
              duration: duration,
              margin: margin,
              //decoration: calendarStyle.selectedDecoration,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(text, style: calendarStyle.selectedTextStyle),
            );
          },
          // week day label
          dowBuilder: (context, DateTime day) {
            log.fine('dowBuilder()');
            log.finest('day: ', day);
            if (day.weekday == DateTime.sunday) {
              final text = DateFormat.E().format(day);

              return Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.red, fontSize: 24),
                ),
              );
            }
          },
        ),
        //
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
