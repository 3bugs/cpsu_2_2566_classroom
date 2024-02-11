import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CLASSROOM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const _keypad = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    // -2 = Clear, -1 = Back
    [-2, 0, -1]
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _input = '';

  @override
  Widget build(BuildContext context) {
    print('Your input is $_input');

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(Icons.security, size: 80.0),
              SizedBox(height: 8.0),
              Text('PIN LOGIN',
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < _input.length; i++)
                Icon(Icons.radio_button_checked),
              for (var i = 0; i < 6 - _input.length; i++)
                Icon(Icons.radio_button_unchecked),
            ],
          ),
          _buildKeypad(),
        ],
      ),
    );
  }

  Column _buildKeypad() {
    return Column(
      children: [
        // _buildRow([1, 2, 3]),
        // _buildRow([4, 5, 6]),
        // _buildRow([7, 8, 9]),

        for (var row in HomePage._keypad) _buildRow(row),
      ],
    );
  }

  Widget _buildRow(List<int> numList) {
    List<int> myList = [
      for (var i = 2; i <= 100; i++)
        if (i % 2 == 0) i
    ];

    // var oldList = [1, 2, 3, 4, 5];
    // var newList = oldList.map((int num) => num * 10).toList();

    // List<Widget> widgets = [];
    //
    // for (var num in numList) {
    //   Widget w = _buildButton(num);
    //   widgets.add(w);
    // }

    // High order function
    //var widgets = numList.map((int num) => _buildButton(num)).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //children: numList.map((int num) => _buildButton(num)).toList(),
      children: [
        // Collection for
        for (var num in numList) _buildButton(num),
      ],
    );
  }

  Widget _buildButton(int num) {
    String? label;
    // num = 0-9
    List<String> labelList = [
      'ZERO',
      'ONE',
      'TWO',
      'THREE',
      'FOUR',
      'FIVE',
      'SIX',
      'SEVEN',
      'EIGHT',
      'NINE',
    ];

    if (num >= 0 && num <= 9) {
      label = labelList[num];
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _input = num == -1
                ? _input.substring(0, _input.length - 1)
                : num == -2
                    ? ''
                    : _input + num.toString();
          });
        },
        child: Container(
          width: 60.0, // 160 = 1 inch
          height: 60.0,
          //margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: num >= 0 && num <= 9
                ? Border.all(color: Colors.deepPurple)
                : null,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (num >= 0 && num <= 9)
                  Text(
                    num.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (num >= 0 && num <= 9)
                  Text(label ?? '', style: TextStyle(fontSize: 10.0)),
                if (num == -2) Icon(Icons.close),
                if (num == -1) Icon(Icons.backspace),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
