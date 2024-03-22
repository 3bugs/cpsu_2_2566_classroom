import 'dart:convert';

import '../models/class_session.dart';
import '../services/api_caller.dart';

class ClassSessionsRepository {
  static final List<ClassSession> _classSessions = [];

  Future<List<ClassSession>> fetchClassSessions() async {
    var data = await ApiCaller().get('/class-schedule');
    List list = jsonDecode(data);
    var cs = list.map((item) => ClassSession.fromJson(item)).toList();
    _classSessions.clear();
    _classSessions.addAll(cs);
    return _classSessions;
  }

  List<ClassSession> get classSessions => _classSessions;
}
