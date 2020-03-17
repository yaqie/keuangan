import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keuangan/pages/daftar.dart';
import 'package:keuangan/pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:keuangan/pages/delayed_animation.dart';

class LoginInput extends StatefulWidget {
  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  signIn(String email,password) async{
    Map data = {
      'email' : email,
      'password' : password,
    };
    var jsonData = null;
    SharedPreferences sharedPeferences = await SharedPreferences.getInstance();
    var response = await http.post("http://keuangan.berdagang.id/login.php",body:data);
    if(response.statusCode == 200){
      jsonData = json.decode(response.body);
      if(jsonData['status'] == '0'){
        setState(() {
          _isLoading = false;
        });
        print('gagal');
        Toast.show("Login gagal! Cek email dan password", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      } else {
        setState(() {
          sharedPeferences.setString('email', jsonData['email']);
          sharedPeferences.setString('hp', jsonData['hp']);
          sharedPeferences.setString('pin', jsonData['email']);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
            (Route<dynamic> route) => false,
          );
        });
      }
      
    } else {
      print(response.body);
    }

  }

  @override
  void initState() { 
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
    checkStatusLogin();
  }

  SharedPreferences sharedPreferences;

  checkStatusLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('email') != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
        (Route<dynamic> route) => false,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF010F3F),
      // backgroundColor: Color(0xFF1F3379),
      appBar: AppBar(
        // backgroundColor: Color(0xFF1F3379),
        backgroundColor: Color(0xFF010F3F),
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.white,
        )
      ),
      body: 
        _isLoading ? 
        Center(
          child: Image.asset('images/loading2.gif'),
        ) : 
        ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top:0.0),
                  child:
                  Column(
                    children: <Widget>[
                      DelayedAnimation(
                        child: Container(
                          child: Image.asset('images/loginpin.png'),
                        ),
                      ),
                      DelayedAnimation(
                        child: Container(
                          padding: const EdgeInsets.only(top:50.0),
                          child: Text('Money Manager',textAlign: TextAlign.center,style:TextStyle(color: Color(0xFFFFFFFF),fontWeight: FontWeight.bold,fontSize: 35)),
                        ),
                        delay: delayedAmount + 100,
                      ),
                      DelayedAnimation(
                        child: Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Text('Masuk untuk memulai sesi anda',textAlign: TextAlign.center, style:TextStyle(color: Color(0xFF91D5FF),fontSize: 18,)),
                        ),
                        delay: delayedAmount + 600,
                      ),
                      DelayedAnimation(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0,top:30),
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: new TextStyle(color: Color(0xFFFFFFFF)),
                            // controller: _alamatController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF162867),
                              contentPadding: const EdgeInsets.only(left: 20.0,right: 20.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF162867)),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF162867)),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              border: InputBorder.none,
                              hintText: 'Email / Nohp',
                              hintStyle: TextStyle(fontSize: 20.0, color: Color(0xFF3451B5)),
                            ),
                          ),
                        ),
                        delay: delayedAmount + 900,
                      ),
                      DelayedAnimation(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: TextFormField(
                                  controller: passwordController,
                                  style: new TextStyle(color: Color(0xFFFFFFFF)),
                                  obscureText: true,
                                  enableInteractiveSelection: false,
                                  // controller: _nominalController,
                                  // keyboardType: TextInputType.visiblePassword,
                                  // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFF162867),
                                    contentPadding: const EdgeInsets.only(left: 20.0,right: 20.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFF162867)),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFF162867)),
                                      borderRadius: BorderRadius.circular(25.7),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(fontSize: 20.0, color: Color(0xFF3451B5)),
                                  ),
                                  validator: (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Password is required';
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: RawMaterialButton(
                                  elevation: 2.0,
                                  shape: CircleBorder(),
                                  fillColor: Color(0xFF34B2FF),
                                  onPressed: (){
                                    setState(() {
                                      _isLoading = true;
                                      signIn(emailController.text,passwordController.text);
                                    });
                                  },
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFFFFFFFF),
                                    size: 25.0,
                                  ),
                                  constraints: BoxConstraints.tightFor(
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                )
                              ),
                              
                            ],
                          ),
                        ),
                        delay: delayedAmount + 1200,
                      ),
                      DelayedAnimation(
                        child: Container(
                          child:new RichText(
                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                                // new TextSpan(text: 'Belum punya akun ? '),
                                new TextSpan(
                                  text: 'Lupa password ?',
                                  // recognizer:new TapGestureRecognizer()..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context) => Daftar())),
                                  recognizer:new TapGestureRecognizer()..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context) => Daftar())),
                                  style: new TextStyle(
                                    color:Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.bold,
                                  )
                                ),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.only(top:10.0,bottom:30.0),
                        ),
                        delay: delayedAmount + 1500,
                      ),
                      
                      
                      
                    ],
                  ),
                ),
                // Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }



}