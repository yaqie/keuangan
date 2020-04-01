import 'dart:async';
import 'package:flutter/material.dart';
import 'package:keuangan/pages/login.dart';
import 'package:keuangan/pages/logininput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatelessWidget {
  SharedPreferences sharedPreferences;
  logout() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            // color: Color(0xFF010F3F),
            color: Color(0xFF1F3379),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 50,bottom: 15),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: 
                        NetworkImage('https://adminlte.io/themes/AdminLTE/dist/img/user3-128x128.jpg'),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                  Text('Ahmad Yahya',style: TextStyle(fontSize: 22,color:Colors.white),),
                  Text('ahmadyahyay@gmail.com',style: TextStyle(color:Colors.white),)
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.insert_chart),
            title: Text('Grafik',style: TextStyle(fontSize: 18),),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Beri kami bintang',style: TextStyle(fontSize: 18),),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Bagikan aplikasi',style: TextStyle(fontSize: 18),),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Pengaturan',style: TextStyle(fontSize: 18),),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Tentang',style: TextStyle(fontSize: 18),),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Keluar',style: TextStyle(fontSize: 18),),
            onTap: (){
              logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}