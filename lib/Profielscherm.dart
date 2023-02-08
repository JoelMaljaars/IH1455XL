import 'package:flutter/material.dart';
import 'package:pwsdikketrekker/home.dart';
import 'package:pwsdikketrekker/main.dart';
import 'package:pwsdikketrekker/services/zermelo/zermelo.dart';
import 'package:zermelo/Zermelo.dart';
import 'Colors.dart';



class Profielscherm extends StatelessWidget {
  const Profielscherm({Key? key}) : super(key: key);



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
              title: Text(
                'Profiel',
                style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
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
        backgroundColor: blauw,

        body: Align(
            alignment: FractionalOffset.bottomCenter,
              //width: MediaQuery.of(context).size.width,
            child: Container(
              height: 650,
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
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                      transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                      child: Text('hoi',
                        //zermeloService!.currentUser.firstName,
                          textScaleFactor: 3.0,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ))),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 340,
                    height: 50,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Klas:',
                            textScaleFactor: 1.4,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: 340,
                    height: 50,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Leerjaar:',
                            textScaleFactor: 1.4,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
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
                               MaterialPageRoute(
                                   builder: (_) => const HomeScreen()),
                              );
                            },
                            child: Text(
                              'Rooster',
                              textScaleFactor: 1.8,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: 340,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    // child: ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.white,
                    //     elevation: 0,
                    //   ),
                    //   onPressed: () {
                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(
                    //     //       builder: (_) => const Cijferlijst()),
                    //     // );
                    //   },
                    //   child: Text(
                    //     'Cijfers ',
                    //     textScaleFactor: 1.8,
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: 340,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    // child: ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.white,
                    //     elevation: 0,
                    //   ),
                    //   onPressed: () {
                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(
                    //     //       builder: (_) => const Meldingen()),
                    //     // );
                    //   },
                    //   child: Text(
                    //     'Meldingen',
                    //     textScaleFactor: 1.8,
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
          ),

        )
      );

  }
}