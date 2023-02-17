import 'login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'Colors.dart';


class qrscannerscreen extends StatelessWidget {
  const qrscannerscreen({Key? key}) : super(key: key);

  // String barcode = "";
  // Future scanBarcode() async{
  //   String barcodeResultaat = await FlutterBarcodeScanner.scanBarcode('#ff6666', "Cancel", true, ScanMode.QR);
//
  //   setState(() {
  //     barcode = barcodeResultaat;
  //   });
//
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: true,

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
        body: Card(
          margin: EdgeInsets.only(top: 50, left: 30, right: 30),
          color: lichtgrijs,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            margin: EdgeInsets.all(10),
            height: 650,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 70),
                  width: 300,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5))),

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black87,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 22,
                        ),
                        Text(
                          '  Terug',
                          textScaleFactor: 1.6,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'type'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),


      ),
    );
  }
}

