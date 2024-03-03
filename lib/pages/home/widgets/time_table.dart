import 'dart:convert';

import 'package:classroom/models/country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  List<Country>? _countries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            var dio = Dio(BaseOptions(responseType: ResponseType.plain));
            var response =
                await dio.get('https://api.sampleapis.com/countries/countries');
            print('Status code: ${response.statusCode}');
            response.headers.forEach((name, values) {
              print('$name: $values');
            });
            print(response.data.toString());

            setState(() {
              List list = jsonDecode(response.data.toString());

              _countries = list.map((item) => Country.fromJson(item)).toList();

              // for (var i = 0; i < list.length; i++) {
              //   var map = list![i];
              //   var name = map['name'];
              //   var capital = map['capital'];
              //   var flag = map['media']['flag'];
              //   var population = map['population'];

              //   var country = Country(
              //     name: name,
              //     capital: capital,
              //     population: population,
              //     flag: flag,
              //   );
              //   _countries!.add(country);
              // }
            });
          },
          child: Text('Test API'),
        ),
        Expanded(
          child: _countries == null
              ? SizedBox.shrink()
              : ListView.builder(
                  itemCount: _countries!.length,
                  itemBuilder: (context, index) {
                    var country = _countries![index];

                    return ListTile(
                      title: Text(country.name ?? ''),
                      subtitle: Text(country.capital ?? ''),
                      trailing: country.flag == ''
                          ? null
                          : Image.network(
                              country.flag ?? '',
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error, color: Colors.red);
                              },
                            ),
                      onTap: () {
                        print('You click ${country.name}');
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
