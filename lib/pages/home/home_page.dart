import 'package:classroom/pages/home/widgets/attendance.dart';
import 'package:classroom/pages/home/widgets/notification.dart';
import 'package:classroom/pages/home/widgets/time_table.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  

  @override
  Widget build(BuildContext context) {
    Widget _buildPageBody() {
      switch (_selectedIndex) {
        case 0:
          return const TimeTable();
        case 1:
          return const Attendance();
        case 2:
          return const AppNotification();
        default:
          return const TimeTable();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomNavigationBar(
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                currentIndex: _selectedIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    label: 'ตารางเรียน/สอบ',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox.shrink(),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    label: 'แจ้งเตือน',
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 16.0,
            right: 0.0,
            left: 0.0,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check,
                            color: _selectedIndex == 1
                                ? Theme.of(context).colorScheme.primary
                                : null),
                        SizedBox(height: 8.0),
                        Text(
                          'เช็คชื่อ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _selectedIndex == 1
                                ? Theme.of(context).colorScheme.primary
                                : null,
                            fontSize: _selectedIndex == 1 ? 16.0 : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: _buildPageBody(),
      ),
    );
  }
}
