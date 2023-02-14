import 'package:flutter/material.dart';
import 'package:zermelo/Zermelo.dart';
import '../../main.dart';

class ZermeloService {
  User? _currentUser;
  Zermelo? _zermelo;

  ZermeloService() {
    print("init ZermeloService");

    dynamic school = box!.get("school");
    dynamic accessToken = box!.get("access_token");

    if (accessToken is String &&
        accessToken.length > 10 &&
        school is String &&
        school.length > 1) {
      _zermelo = Zermelo.getAPI(school, accessToken);

      _zermelo!.users.get(id: "~me").then((dynamic user) {
        if (user is User) {
          print("ingelogd als: ${user.firstName}");
          _currentUser = user;
        }
      });
    }
  }

  User get currentUser => _currentUser!;
  Zermelo get zermelo => _zermelo!;

  Future<dynamic> login({
    required String school,
    required String code,
  }) async {
    dynamic accessToken = await Zermelo.getAccessToken(school, code);

    if (accessToken.toString().contains('400')) {
      return "De koppelcode is niet geldig :(";
    } else if (accessToken.toString().contains('404')) {
      return "De school is niet geldig :(";
    } else if (accessToken is! String) {
      return "Onbekende error, probeer het later nog eens :)";
    }

    _zermelo = Zermelo.getAPI(school, accessToken);

    _currentUser = await _zermelo!.users.get(id: "~me");

    await box!.putAll({
      "school": school,
      "access_token": accessToken,
      "is_logged_in": true,
    });

    print({
      "school": school,
      "access_token": accessToken,
      "is_logged_in": true,
    });

    return true;
  }

  Future<dynamic> logout() async {
    _zermelo = null;

    _currentUser = null;

    await box!.deleteAll([
      "school",
      "access_token",
      "is_logged_in",
    ]);

    return true;
  }

  Future<List<Day>> getDays(context) async {
    if (_zermelo == null) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text('Niet ingelogd :('),
        ),
      );
      return [];
    } else {
      List<dynamic> appointments = await _zermelo!.appointments.get(
        DateTime.now().subtract(
          Duration(days: 2),
        ),
        DateTime.now().add(
          Duration(days: 30),
        ),
      );

      List<Day> days = [];

      for (var i = 0; i < appointments.length; i++) {
        final f = appointments[i];
        int dayIndex = -1;
        if (days.isNotEmpty) {
          DateTime date = DateTime.fromMillisecondsSinceEpoch(f.start * 1000);
          final appDate = "${date.day}/${date.month}";

          dayIndex = days.indexWhere(
              (d) => (("${d.date.day}/${d.date.month}") == (appDate)));
        }

        if (dayIndex < 0) {
          Day day = Day(
              appointments: [],
              date: DateTime.fromMillisecondsSinceEpoch(f.start * 1000));

          day.appointments.add(f);

          days.add(day);
        } else {
          days[dayIndex].appointments.add(f);
        }
      }

      days.sort((Day a, Day b) => a.date.compareTo(b.date));

      for (var day in days) {
        day.appointments
            .sort((Appointment a, Appointment b) => a.start.compareTo(b.start));
      }

      return days;
    }
  }
}

class Day {
  final DateTime date;
  List<Appointment> appointments;

  Day({required this.date, required this.appointments});
}
