import 'package:flutter/material.dart';

class Pendapatan extends StatefulWidget {
  @override
  _PendapatanState createState() => _PendapatanState();
}

class _PendapatanState extends State<Pendapatan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pendapatan'),
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.white,
        )
      ),
      body: ListView(
        children: <Widget>[
          Column(children: <Widget>[
            Image(image: AssetImage('images/pemasukan.gif')),
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
              color: Colors.green,
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
                "Masukan pendapatan anda",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}