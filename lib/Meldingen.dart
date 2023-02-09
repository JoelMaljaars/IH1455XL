import 'package:flutter/material.dart';
import 'Colors.dart';

class Meldingen extends StatelessWidget {
  const Meldingen({Key? key}) : super(key: key);

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
                'Meldingen',
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
        backgroundColor: blauw,


      ),
    );
  }
}
