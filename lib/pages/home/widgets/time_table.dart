import 'package:flutter/material.dart';

class TimeTable extends StatelessWidget {
  const TimeTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 0; i < 20; i++)
            ListTile(
              title: Text('TimeTable ${i + 1}'),
              subtitle: Text('View your timetable'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print('View timetable ${i + 1}');
              },
            ),
        ],
      ),
    );
  }
}
