import 'package:flutter/material.dart';
import 'package:pwsdikketrekker/Profielscherm.dart';
import 'Roosterpagina.dart';
import 'main.dart';
import 'Colors.dart';
import 'Services/Zermelo/zermelo.dart';
import 'package:zermelo/Zermelo.dart';
//import 'Services/Zermelo/Util.dart';
//import 'Services/Zermelo/User/User.dart';
//import 'Services/Zermelo/';
//import 'Services/Zermelo/zermelo.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: blauw,
        body: SizedBox(
          width: double.infinity,
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin: EdgeInsets.only(top: 140),
                transform: Matrix4.translationValues(0.0, 10.0, 0.0),
                child: Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0),
                child: const Text(
                  'DeTa',
                  textAlign: TextAlign.center,
                  textScaleFactor: 4.0,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'type',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Card(
                  margin: EdgeInsets.only(top: 90),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.white,
                  elevation: 5.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    height: 260,
                    width: 350,
                    child: Column(
                      children: [
                        Container(
                          child: TextField(
                            controller: text1,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black54)),
                              labelStyle: TextStyle(color: Colors.black54),
                              labelText: 'Schoolnaam',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: text2,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black54)),
                              labelStyle: TextStyle(color: Colors.black54),
                              labelText: 'Koppelcode',
                            ),
                            obscureText: (true),
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(top: 0),
                        //   height: 10,
                        //   width: 10,
                        //   child: TextButton(
                        //     style: TextButton.styleFrom(
                        //         textStyle: const TextStyle(fontSize: 20)),
                        //
                        //     onPressed: () {},
                        //     child: const Text('Hulp nodig?'),
                        //     // TODO: Hier nog hulpknop maken ~jo
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          width: 350,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black87,
                            ),
                            onPressed: () async {
                              String school = text1.text;
                              String code = text2.text;
                              await zermeloService!
                                  .login(school: school, code: code);

                                //ignore: use_build_context_synchronously;
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return const Profielscherm();
                              }));
                            },
                            child: Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'type',
                                  fontSize: 20
                                ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Developed by DT developers',
                  style: TextStyle(color: Colors.white, fontFamily: 'type'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
