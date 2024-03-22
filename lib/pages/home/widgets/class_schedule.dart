import 'package:classroom/repositories/class_sessions_repository.dart';
import 'package:flutter/material.dart';

import '../../../models/class_session.dart';

class ClassSchedule extends StatefulWidget {
  const ClassSchedule({super.key});

  @override
  State<ClassSchedule> createState() => _ClassScheduleState();
}

class _ClassScheduleState extends State<ClassSchedule> {
  List<ClassSession>? _classSessions;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    var sessions = await ClassSessionsRepository().fetchClassSessions();
    setState(() {
      _classSessions = sessions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _classSessions?.length ?? 0,
      itemBuilder: (context, index) {
        var session = _classSessions?[index];

        Widget icon = SizedBox.shrink();
        if (session?.status == true) {
          icon = Icon(Icons.done, color: Colors.green);
        } else if (session?.status == false) {
          icon = Icon(Icons.close, color: Colors.red);
        } else if (session?.canCheckIn == true) {
          icon = OutlinedButton(
            child: Text('Check In'),
            onPressed: () async {
              await session?.checkIn();
              loadData();
            },
          );
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text(session?.date ?? ''),
            trailing: icon,
          ),
        );
      },
    );
  }
}
