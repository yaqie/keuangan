import 'package:flutter/material.dart';
import 'package:keuangan/pages/dashboard.dart';
import 'package:keuangan/pages/dashboard.dart';

class Berhasil extends StatefulWidget {
  @override
  _BerhasilState createState() => _BerhasilState();
}

class _BerhasilState extends State<Berhasil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(children: <Widget>[
              Image(image: AssetImage('images/75_smile.gif')),
              Padding(
                padding: const EdgeInsets.only(top:40.0,left: 20,right: 20),
                child: Text('Kirim Data Berhasil',style: TextStyle(fontSize: 30),),
              ),
            ],),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: FlatButton(
              color: Color(0xFF1F3379),
              textColor: Color(0xFFFFFFFF),
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(20.0),
              splashColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
                // side: BorderSide(color: Colors.red)
              ),
              onPressed: (){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                "Kembali ke beranda",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}