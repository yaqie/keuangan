import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keuangan/pages/daftar.dart';
import 'package:keuangan/pages/dashboard.dart';
import 'package:keuangan/pages/delayed_animation.dart';
import 'package:keuangan/pages/logininput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
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
      // backgroundColor: Color(0xFF010F3F),
      backgroundColor: Color(0xFF1F3379),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                DelayedAnimation(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top:50.0),
                      child: Image(image: AssetImage('images/login.png')),
                    ),
                  ),
                ),
                DelayedAnimation(
                  child: Container(
                    padding: const EdgeInsets.only(top:50.0),
                    child: Text('Money Manager',textAlign: TextAlign.center,style:TextStyle(color: Color(0xFFFFFFFF),fontWeight: FontWeight.bold,fontSize: 35)),
                  ),
                  delay: delayedAmount + 300,
                ),
                DelayedAnimation(
                  child: Container(
                    padding: const EdgeInsets.only(top:25.0),
                    child: Text('Catat dan atur keuanganmu,\nnikmati mudahnya mengatur uang',textAlign: TextAlign.center, style:TextStyle(color: Color(0xFF91D5FF),fontSize: 18,)),
                  ),
                  delay: delayedAmount + 600,
                ),
                
                DelayedAnimation(
                  delay: delayedAmount + 900,
                  child: Padding(
                    padding: const EdgeInsets.only(top:50.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                        color: Color(0xFF34B2FF),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginInput()),
                          );
                        },
                        child: Text(
                          "Masuk ke akun anda",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
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
                            text: 'Daftar akun baru',
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
                    padding: const EdgeInsets.only(top:40.0,bottom:30.0),
                  ),
                  delay: delayedAmount + 1200,
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}