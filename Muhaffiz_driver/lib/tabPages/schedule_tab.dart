import 'package:flutter/material.dart';

class ScheduleTabPage extends StatefulWidget {
  const ScheduleTabPage({Key? key}) : super(key: key);

  @override
  State<ScheduleTabPage> createState() => _ScheduleTabPageState();
}

class _ScheduleTabPageState extends State<ScheduleTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          "Schedule"
      ),
    );;
  }
}
