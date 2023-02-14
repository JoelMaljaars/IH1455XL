import 'login.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'Colors.dart';


class hulpscreen extends StatelessWidget {
  const hulpscreen({Key? key}) : super(key: key);

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
                'Hulp',
                style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'type'),
              ),
              leading: TextButton(
                child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                    size: 30
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return LoginScreen();
                          }));
                },
              ),

              backgroundColor: Colors.white,
              elevation: 0,
            )
        ),
        backgroundColor: blauw,


      ),
    );
  }
}

