// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pwsdikketrekker/main.dart';
import 'package:pwsdikketrekker/services/zermelo/zermelo.dart';
import 'Colors.dart';
import 'Roosterpagina.dart';
import 'Cijferlijst.dart';
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
  String title = "?";
  String subtitle = "???";

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text(
          'Profiel',
          style: TextStyle(
              fontSize: 35, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: Icon(Icons.person, color: Colors.black, size: 45),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color.fromRGBO(252, 202, 46, 1),
      //   onPressed: () => fillDays(context),
      //   child: const Icon(Icons.add),
      // ),
      body: ListView(
        children: [
          Text(title, style: TextStyle(fontSize: 30)),
          Text(subtitle, style: TextStyle(fontSize: 20)),
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
                              child: Text(
                                '${appointment.startTimeSlot}-${appointment.endTimeSlot}: ${_getClass(appointment)}',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
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
          // Expanded(
          //   child: Align(
          //     alignment: FractionalOffset.bottomCenter,
          //     child: Container(
          //       width: MediaQuery.of(context).size.width,
          //       height: 650,
          //       decoration: BoxDecoration(
          //         color: blauw,
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(40),
          //           topRight: Radius.circular(40),
          //         ),
          //       ),
          //       child: Column(
          //         children: [
          //           Container(
          //             transform: Matrix4.translationValues(0.0, -80.0, 0.0),
          //             width: 160,
          //             height: 160,
          //             decoration: BoxDecoration(
          //               image: DecorationImage(
          //                   image: AssetImage(
          //                       "assets/images/profile_image_avatar2.jpg"),
          //                   fit: BoxFit.fill),
          //               color: Colors.green,
          //               shape: BoxShape.circle,
          //             ),
          //           ),
          //           Container(
          //               transform: Matrix4.translationValues(0.0, -40.0, 0.0),
          //               child: Text(zermeloService!.currentUser.firstName,
          //                   textScaleFactor: 3.0,
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.w600,
          //                   ))),
          //           Container(
          //             margin: EdgeInsets.only(top: 20),
          //             width: 340,
          //             height: 50,
          //             child: Container(
          //               margin: EdgeInsets.only(left: 15),
          //               child: Align(
          //                 alignment: Alignment.center,
          //                 child: Text('Klas:',
          //                     textScaleFactor: 1.4,
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.w400,
          //                     )),
          //               ),
          //             ),
          //             decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.all(Radius.circular(5))),
          //           ),
          //           Container(
          //             margin: EdgeInsets.only(top: 15),
          //             width: 340,
          //             height: 50,
          //             child: Container(
          //               margin: EdgeInsets.only(left: 15),
          //               child: Align(
          //                 alignment: Alignment.center,
          //                 child: Text('Leerjaar:',
          //                     textScaleFactor: 1.4,
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.w400,
          //                     )),
          //               ),
          //             ),
          //             decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.all(Radius.circular(5))),
          //           ),
          //           Container(
          //               margin: EdgeInsets.only(top: 15),
          //               width: 340,
          //               height: 50,
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.all(Radius.circular(5))),
          //               child: ElevatedButton(
          //                 style: ElevatedButton.styleFrom(
          //                   primary: Colors.white,
          //                   elevation: 0,
          //                 ),
          //                 onPressed: () {
          //                   //Navigator.push(
          //                   //  context,
          //                   //  MaterialPageRoute(
          //                   //      builder: (_) => const Roosterpagina()),
          //                   //);
          //                 },
          //                 child: Text(
          //                   'Rooster',
          //                   textScaleFactor: 1.8,
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               )),
          //           Container(
          //             margin: EdgeInsets.only(top: 15),
          //             width: 340,
          //             height: 50,
          //             decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.all(Radius.circular(5))),
          //             child: ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                 primary: Colors.white,
          //                 elevation: 0,
          //               ),
          //               onPressed: () {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (_) => const Cijferlijst()),
          //                 );
          //               },
          //               child: Text(
          //                 'Cijfers ',
          //                 textScaleFactor: 1.8,
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Container(
          //             margin: EdgeInsets.only(top: 15),
          //             width: 340,
          //             height: 50,
          //             decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.all(Radius.circular(5))),
          //             child: ElevatedButton(
          //               style: ElevatedButton.styleFrom(
          //                 primary: Colors.white,
          //                 elevation: 0,
          //               ),
          //               onPressed: () {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (_) => const Meldingen()),
          //                 );
          //               },
          //               child: Text(
          //                 'Meldingen',
          //                 textScaleFactor: 1.8,
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
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
        return "Mentoruur";
        break;
      case "kv1":
        return "Kunst Vorming";
        break;
      case "ne":
        return "Nederlands";
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
