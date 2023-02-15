import 'package:flutter/material.dart';
import 'package:pwsdikketrekker/main.dart';
import 'package:pwsdikketrekker/services/zermelo/zermelo.dart';
import 'Colors.dart';
import 'package:zermelo/Zermelo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  List<Day> days = [];
  String title = "Date";
  String subtitle = "Day";

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<List<Day>> fillDays(context) async {
    if (days.isNotEmpty) {
      return days;

    }
    days = await zermeloService!.getDays(context);
    return days;

  }
  Color _getTypeColor(Appointment appointment) {
    if (appointment.cancelled) {
      return Colors.red; // set red color for cancelled appointment
    } else if (appointment.moved) {
      return Colors.orange; // set orange color for moved appointment
    } else if (appointment.modified) {
      return Colors.blue; // set blue color for modified appointment
    } else {
      return Colors.black12; // default color for non-modified appointment
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: blauw,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            toolbarHeight: 80,
            centerTitle: true,
            title: Text(
              'Rooster',
              style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'type'),
            ),
            leading: TextButton(
              child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                  size: 30
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            backgroundColor: Colors.white,
            elevation: 0,
          )
      ),

      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Text(title, style: TextStyle(fontSize: 35, color: Colors.white, fontFamily: 'type')),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Text(subtitle, style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: 'type')),
          ),
          Container(
            height: 1000,
            child: FutureBuilder(
              key: Key("nietHerbouwen"),
              future: fillDays(context),
              builder: (context, AsyncSnapshot<List<Day>> snapshot) {
                if (snapshot.hasData) {
                  return PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) {
                      Day day = days[index];
                      setState(() {
                        List<String> texts = _getDayReference(day.date);
                        title = texts[0];
                        subtitle = texts[1];
                      });
                    },
                    itemCount: days.length,
                    itemBuilder: (contxt, index) {
                      Day day = days[index];
                      print(
                          'day $index aan het bouwen, ..... met zoveel apps: ${day.appointments.length}');

                      return Container(
                        height: 1000,
                        child: ListView.builder(
                          itemCount: day.appointments.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            Appointment appointment = day.appointments[index];
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              color: _getTypeColor(appointment),
                              child: Row(
                                children: [
                                  Text(
                                      '${appointment.startTimeSlot}      ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'type'

                                    ),
                                  ),
                                  Text(
                                    '${_getClass(appointment)}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: 'type'
                                    ),
                                  ),
                                ],
                              )
                              //TODO oude afspraken verwijderen als er veranderingen in het rooster hebben plaatsgevonden
                            );
                          },
                        ),
                      );
                    },
                  );
                }

                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getClass(appointment) {
    switch (appointment.subjects[0].toString()) {
      case "falt":
        return "Frans";
        break;
      case "du":
        return "Duits";
        break;
      case "ma":
        return "Maatschappijleer";
        break;
      case "ges":
        return "Geschiedenis";
        break;
      case "ec":
        return "Economie";
        break;
      case "lo":
        return "Lichamelijke Opvoeding";
        break;
      case "bg":
        return "Wiskunde D";
        break;
      case "fi":
        return "Natuurkunde";
        break;
      case "nat":
        return "Natuurkunde";
        break;
      case "wisb":
        return "Wiskunde B";
        break;
      case "en":
        return "Engels";
        break;
      case "netl":
        return "Nederlands";
        break;
      case "kv1":
        return "Kunst Vorming";
        break;
      case "ne":
        return "Nederlands";
        break;
      case "gds":
        return "Godsdienst";
        break;
      case "nlt":
        return "NLT";
        break;
      case "schk":
        return "Scheikunde";
        break;
      case "in":
        return "Informatica";
        break;
      case "entl":
        return "Engels";
        break;
      case "to":
        return "TO";
        break;
      case "biol":
        return "Biologie";
        break;
      case "z_uur":
        return "Z-uur";
        break;
      case "wisa":
        return "Wiskunde A";
        break;
      case "Act":
        return "Act";
        break;
      default:
        return "${appointment.subjects[0]}";
        break;
    }
  }

  List<String> _getDayReference(DateTime date) {

    return [
      "${date.day.toString()} ${_getMonthName(date)} ${date.year != DateTime
          .now()
          .year ? date.year.toString() : ""}",
      _getDayName(date, false)
    ];

  }

  String _getMonthName(DateTime date) {
    switch (date.month) {
      case 1:
        return "Jan";
        break;
      case 2:
        return "Feb";
        break;
      case 3:
        return "Maart";
        break;
      case 4:
        return "April";
        break;
      case 5:
        return "Mei";
        break;
      case 6:
        return "Juni";
        break;
      case 7:
        return "Juli";
        break;
      case 8:
        return "Aug";
        break;
      case 9:
        return "Sept";
        break;
      case 10:
        return "Okt";
        break;
      case 11:
        return "Nov";
        break;
      case 12:
        return "Dec";
        break;
    }
    return "";
  }

  String _getDayName(DateTime date, bool full) {
    String extra = "";
    if (full) {
      extra = " ${date.day.toString()} ${_getMonthName(date)}";
    }
    switch (date.weekday) {
      case 1:
        return "Maandag$extra";
        break;
      case 2:
        return "Dinsdag$extra";
        break;
      case 3:
        return "Woensdag$extra";
        break;
      case 4:
        return "Donderdag$extra";
        break;
      case 5:
        return "Vrijdag$extra";
        break;
      case 6:
        return "Zaterdag$extra";
        break;
      case 7:
        return "Zondag$extra";
        break;
    }
    return "";
  }
}
