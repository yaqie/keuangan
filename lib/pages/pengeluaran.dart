import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indonesia/indonesia.dart';
import 'package:keuangan/pages/berhasil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';

class Pengeluaran extends StatefulWidget {
  @override
  _PengeluaranState createState() => _PengeluaranState();
}

class _PengeluaranState extends State<Pengeluaran> {

  bool _isLoading = false;

  TextEditingController _catatanController = new TextEditingController();
  TextEditingController _jumlahController = new TextEditingController();

  SharedPreferences sharedPreferences;

  rupiah_input(String jumlah) async{
    if(jumlah.isEmpty){
      _jumlahController.value = TextEditingValue(
        text: "",
      );
    } else {
      final _newValue = ""+rupiah(jumlah);
      _jumlahController.value = TextEditingValue(
        text: _newValue,
        selection: TextSelection.fromPosition(
          TextPosition(offset: _newValue.length),
        ),
      );
    }
  }

  kirim(String catatan,asd) async{
    FocusScope.of(context).unfocus();
    var jumlah123 = asd.replaceAll('.', '');
    var jumlah2 = jumlah123.replaceAll('Rp', '');
    var jumlah = int.parse(jumlah2);
    assert(jumlah is int);

    print(catatan);
    print(jumlah);

    sharedPreferences = await SharedPreferences.getInstance();
    var sessionEmail = sharedPreferences.getString('email');
    print(sessionEmail);

    Map data = {
      'email' : sessionEmail,
      'catatan' : catatan,
      'jumlah' : jumlah.toString(),
      'kategori' : '0',
    };
    var jsonData;
    var response = await http.post("http://keuangan.berdagang.id/tambah.php",body:data);
    if(response.statusCode == 200){
      jsonData = json.decode(response.body);
      print(response.body);
      if(jsonData['status'] == '1'){
        setState(() {
          _isLoading = false;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Berhasil()),
            (Route<dynamic> route) => false,
          );
        });
      } else if((jsonData['status'] != "1")){
        setState(() {
          _isLoading = false;
          Navigator.of(context).pop();
          Toast.show("gagal dikirim", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        });
      }
      
    } else {
      print(response.body);
    }

  }

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
              child: TextField(
                controller: _catatanController,
                decoration: InputDecoration(labelText: 'Catatan (ex: kebutuhan bulanan)')
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0,left: 20,right: 20),
              child: TextField(
                onChanged: (text) {
                  rupiah_input(text);
                },
                controller: _jumlahController,
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                decoration: InputDecoration(labelText: 'Nominal (ex: 200.000)')
              ),
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
            child: 
            _isLoading == false ?
            FlatButton(
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
                setState(() {
                  _isLoading = true;
                  if (_catatanController.text == "") {
                    _isLoading = false;
                    Toast.show("catatan tidak boleh kosong", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                  } else if (_jumlahController.text == ""){
                    _isLoading = false;
                    Toast.show("jumlah tidak boleh kosong", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                  } else {
                    kirim(_catatanController.text,_jumlahController.text); 
                  }
                });
              },
              child: Text(
                "Masukan pengeluaran anda",
                style: TextStyle(fontSize: 15.0),
              ),
            ) :
            FlatButton(
              color: Colors.grey,
              textColor: Color(0xFFFFFFFF),
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(13.0),
              splashColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(50.0),
                // side: BorderSide(color: Colors.red)
              ),
              onPressed: (){},
              child: 
              Container(
                height: 20,
                width: 20,
                margin: EdgeInsets.all(5),
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor : AlwaysStoppedAnimation(Colors.white),
                ),
              ),
              // CircularProgressIndicator(
              //   backgroundColor: Colors.white,
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}