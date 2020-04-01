import 'package:flutter/material.dart';

class Pengeluaran extends StatefulWidget {
  @override
  _PengeluaranState createState() => _PengeluaranState();
}

class _PengeluaranState extends State<Pengeluaran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pengeluaran'),
        backgroundColor: Colors.red,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.white,
        )
      ),
      body: ListView(
        children: <Widget>[
          Column(children: <Widget>[
            Image(image: AssetImage('images/outcome.gif'),width: 300,),
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 20,right: 20),
              child: TextField(decoration: InputDecoration(labelText: 'Keperluan')),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 20,right: 20),
              child: TextField(decoration: InputDecoration(labelText: 'Nominal')),
            ),
          ],),
        ],
      ),
      bottomNavigationBar: Container(
        color: Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: FlatButton(
              color: Colors.red,
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => LoginInput()),
                // );
              },
              child: Text(
                "Masukan pengeluaran anda",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}