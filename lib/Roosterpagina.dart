// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pwsdikketrekker/main.dart';
import 'package:pwsdikketrekker/services/zermelo/zermelo.dart';
import 'Colors.dart';
import 'Profielscherm.dart';
import 'Meldingen.dart';
import 'login.dart';
import 'package:zermelo/Zermelo.dart';
import 'package:zermelo/User/User.dart';

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
    // setState(() {
    //   days = _days;
    // });
  }

  //final String '${currentUser.firstName} ${currentUser.lastName}';
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

      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color.fromRGBO(252, 202, 46, 1),
      //   onPressed: () => fillDays(context),
      //   child: const Icon(Icons.add),
      // ),
      body: ListView(
        children: [
          // Text(title, style: TextStyle(fontSize: 30, color: Colors.white)),
          // Text(subtitle, style: TextStyle(fontSize: 20)),
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
                      // print(
                      //     'pagina is nu v;eranderd, hier kan je de titel ofzo aanpassen');
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
                              // child: Text(
                              //   '${appointment.startTimeSlot}           ${_getClass(appointment)}',
                              //   style: TextStyle(
                              //     color: Colors.black,
                              //     fontSize: 25,
                              //   ),
                              // ),
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

  Color _getTypeColor(appointment) {
    if (appointment.cancelled) return Color.fromRGBO(255, 100, 100, 1);
    if (appointment.moved) return Colors.orange;
    if (appointment.modified) return Colors.blue;
    // if (this.appointment.valid) return Colors.green;
    return Colors.black12;
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
        return "z_uur";
        break;
      case "wisa":
        return "Wiskunde A";
        break;
      default:
        return "${appointment.subjects[0]}???";
        break;
    }
  }

  List<String> _getDayReference(DateTime date) {
    final now = DateTime.now().add(Duration(hours: 1));
    final diff = date.difference(now).inDays - 1;
    if (diff == -2) {
      return ["Eergisteren", _getDayName(date, true)];
    } else if (diff == -1) {
      return ["Gisteren", _getDayName(date, true)];
    } else if (diff == 0) {
      return ["Vandaag", _getDayName(date, true)];
    } else if (diff == 1) {
      return ["Morgen", _getDayName(date, true)];
    } else if (diff == 2) {
      return ["Overmorgen", _getDayName(date, true)];
    } else if (diff > 2) {
      return ["Overmorgen", _getDayName(date, true)];
    } else if (diff < 2) {
      return [
        "${date.day.toString()} ${_getMonthName(date)} ${date.year != DateTime.now().year ? date.year.toString() : ""}",
        _getDayName(date, false)
      ];
    } else if (diff == 0) {
      return ["Vandaag", _getDayName(date, true)];
    }
    return ["welp", "error ofzoo"];
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
