import 'package:flutter/material.dart';
import 'package:pwsdikketrekker/Roosterpagina.dart';
import 'package:pwsdikketrekker/login.dart';
import 'package:pwsdikketrekker/main.dart';
import 'package:pwsdikketrekker/services/zermelo/zermelo.dart';
import 'package:zermelo/Zermelo.dart';
import 'Colors.dart';
import 'Meldingen.dart';
import '../../main.dart';

class Profielscherm extends StatelessWidget {
  const Profielscherm({Key? key}) : super(key: key);

  // @override
  // Future waitSeconds(int seconds) async {
  //   return Future.delayed(Duration(seconds: seconds));
  //   await waitSeconds(3);
  // }
  // void initState() async{
  //   await waitSeconds(3);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppBar(
                toolbarHeight: 80,
                centerTitle: true,
                title: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Profiel',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'type',
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
              )),
          backgroundColor: Colors.white,
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 650,
              width: double.infinity,
              decoration: BoxDecoration(
                color: blauw,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    transform: Matrix4.translationValues(0.0, -80.0, 0.0),
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/profile_image_avatar2.jpg"),
                          fit: BoxFit.fill),
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                      transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                      child: Text(
                          "${zermeloService?.currentUser?.firstName ?? ''}  ${zermeloService?.currentUser?.prefix ?? ''}  ${zermeloService?.currentUser?.lastName ?? ''}",

                          //zermeloService!.currentUser.firstName,
                          textScaleFactor: 2.7,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'type'))),
                  Container(          //Schoolnaam
                    margin: EdgeInsets.only(top: 20),
                    width: 340,
                    height: 50,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'School:  ${zermeloService?.zermelo?.school ?? ''}',
                          textScaleFactor: 1.6,
                          style: TextStyle(
                              fontWeight: FontWeight.w100, fontFamily: 'type'),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  Container(          //Type gebruiker
                    margin: EdgeInsets.only(top: 15),
                    width: 340,
                    height: 50,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Status:  ${zermeloService?.currentUser?.runtimeType}',
                            textScaleFactor: 1.6,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'type',
                            )),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),


                  Container(
                      margin: EdgeInsets.only(top: 40),
                      width: 340,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen()),
                          );
                        },
                        child: Text(
                          'Rooster',
                          textScaleFactor: 1.8,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'type',
                          ),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: 340,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Meldingen()),
                        );
                      },
                      child: Text(
                        'Meldingen',
                        textScaleFactor: 1.8,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'type',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 340,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5))),

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black87,
                        elevation: 0,
                      ),
                      onPressed: () async {
                        await zermeloService!.logout();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Uitloggen  ',
                            textScaleFactor: 1.8,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'type'),
                          ),
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
