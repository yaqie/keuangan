import 'package:flutter/material.dart';

class Pendapatan extends StatefulWidget {
  @override
  _PendapatanState createState() => _PendapatanState();
}

class _PendapatanState extends State<Pendapatan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pendapatan'),
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.white,
        )
      ),
    );
  }
}