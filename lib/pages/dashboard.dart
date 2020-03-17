import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:indonesia/indonesia.dart';
import 'package:keuangan/pages/logininput.dart';
import 'package:keuangan/pages/pendapatan.dart';
import 'package:keuangan/pages/pengeluaran.dart';
import './maindrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:majascan/majascan.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>{
  SharedPreferences sharedPreferences;
  List data; //DEFINE VARIABLE data DENGAN TYPE List AGAR DAPAT MENAMPUNG COLLECTION / ARRAY

  Future<String> _getData() async {
      sharedPreferences = await SharedPreferences.getInstance();
      String sessionEmail = sharedPreferences.getString('email');
      Map param = {
        'email' : sessionEmail,
      };
      var jsonData;
      var response2 = await http.post("http://keuangan.berdagang.id/catatan.php",body:param);
      jsonData = json.decode(response2.body);
      if (this.mounted){
        if (jsonData['status'] == '0') {
          setState(() {
            data = null;
          });
        } else {
          setState(() {
            data = json.decode(response2.body);
          });
        }
      }
    // return 'success!';
  }

  @override
  void initState() {
    super.initState();
    if(mounted){
      _getData();
      checkStatusLogin();

      // print("woii : "+sharedPreferences.getString('pin'));
    }
  }

  checkStatusLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.getString('pin');
    if (sharedPreferences.getString('email') == null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginInput()),
        (Route<dynamic> route) => false,
      );
    }
  }

  // Future _scan() async {
  //   String qrResult = await MajaScan.startScan(
  //   title: "Pindai Dompet Inacash", 
	//   barColor: Color(0xFFd10e00), 
  // 	titleColor: Colors.white, 
  //   qRCornerColor: Color(0xFFd10e00),
  //   qRScannerColor: Color(0xFFd10e00),
	//   flashlightEnable: true
  //   );
  //   SharedPreferences sharedPeferences = await SharedPreferences.getInstance();
  //   String sessionEmail = sharedPreferences.getString('email');
  //   sharedPeferences.setString('pin', sessionEmail);
  //   if (qrResult == null) {
  //     print('nothing return.');
  //   } else {
  //     print("asd"+sharedPreferences.getString('pin'));
  //     print(qrResult);
  //   }
  // }
  
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: new IconButton(
        //   icon: new Icon(Icons.menu, color: Colors.white),
        //   onPressed: () {},
        // ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              _refreshIndicatorKey.currentState.show();
            },
          ),
        ],
        // backgroundColor: Color(0xFF1F3379),
        backgroundColor: Color(0xFF010F3F),
        elevation: 0,
        centerTitle: false,
      ),
      drawer: MainDrawer(),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _getData,
        child: ListView(
          physics: new ClampingScrollPhysics(),
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  transform: Matrix4.translationValues(0.0, -75.0, 0.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF010F3F),
                    // color: Color(0xFF1F3379),
                  ),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          transform: Matrix4.translationValues(0.0, 40.0, 0.0),
                          child: Image.asset('images/dashboard2.png')
                        ),
                        // Text('data')
                      ],
                    ),
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -135.0, 0.0),
                  padding: const EdgeInsets.only(top:15,left: 10,right: 10,bottom: 15),
                  child:Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: new Card(
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(const Radius.circular(20.0)),
                          ),
                          elevation: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7.0,vertical: 30),
                            child: Row(children: <Widget>[
                              Expanded(
                                flex: 1,
                                child:Column(
                                children: <Widget>[
                                  Text('Pendapatan',textAlign: TextAlign.left,style:TextStyle(color:Colors.grey,fontSize: 13)),
                                  Text(rupiah(5000000),textAlign: TextAlign.left,style:TextStyle(color:Color(0xFF00c925),fontWeight: FontWeight.bold,fontSize: 15))
                                ],) 
                              ),
                              Expanded(
                                flex: 1,
                                child:Column(children: <Widget>[
                                  Text('Pengeluaran',textAlign: TextAlign.left,style:TextStyle(color:Colors.grey,fontSize: 13)),
                                  Text(rupiah(5000000),style:TextStyle(color:Color(0xFFc90000),fontWeight: FontWeight.bold,fontSize: 15))
                                ],) 
                              ),
                              Expanded(
                                flex: 1,
                                child:Column(children: <Widget>[
                                  Text('Balance',style:TextStyle(color:Colors.grey,fontSize: 13)),
                                  Text(rupiah(5000000),style:TextStyle(color:Color(0xFFc97900),fontWeight: FontWeight.bold,fontSize: 15))
                                ],) 
                              ),
                            ],),
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                
                Container(
                  child: 
                  data == null ?
                  Container(
                    transform: Matrix4.translationValues(0.0, -115.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom:5.0),
                          // child: Text('Kamu belum punya catatan apapun',style: TextStyle(color: Color(0xFF1F3379),fontSize: 20),),
                          child: Text('Kamu belum punya catatan apapun',style: TextStyle(color: Color(0xFF010F3F),fontSize: 20),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom:20.0),
                          // child: Text('Kuy catat keuanganmu sekarang!',style: TextStyle(color: Color(0xFF1F3379)),),
                          child: Text('Kuy catat keuanganmu sekarang!',style: TextStyle(color: Color(0xFF010F3F)),),
                        ),
                        Image.asset('images/empty.png'),
                      ],
                    ),
                  ) :
                  ListView.builder( //MEMBUAT LISTVIEW
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data == null ? 0:data.length, //KETIKA DATANYA KOSONG KITA ISI DENGAN 0 DAN APABILA ADA MAKA KITA COUNT JUMLAH DATA YANG ADA
                    itemBuilder: (BuildContext context, int index) { 
                      return Container(
                        transform: Matrix4.translationValues(0.0, -135.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min, children: <Widget>[
                            ListTile(
                              title: new Row(
                                children: <Widget>[
                                  data[index]['kategori'] == '1' ?
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:10.0,top:15.0),
                                    child: Text(rupiah(data[index]['jumlah']),style:TextStyle(color:Color(0xFF00c925),fontWeight: FontWeight.bold,fontSize: 20))
                                  ):
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:10.0,top:15.0),
                                    child: Text(rupiah(data[index]['jumlah']),style:TextStyle(color:Color(0xFFc90000),fontWeight: FontWeight.bold,fontSize: 20))
                                  )
                                ],
                              ),
                              subtitle: new Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:10.0,top:0.0),
                                    child: Text(data[index]['catatan'] + " (" + data[index]['tanggal'] + ")" ,style:TextStyle(color:Colors.grey,fontSize: 18)),
                                  )
                                ],
                              ),
                              leading: 
                              data[index]['kategori'] == '1' ?
                              IconButton(
                                icon: Icon(Icons.file_download,color:Color(0xFF00c925),size: 30),
                                onPressed: () {
                                  
                                },
                              ) :
                              IconButton(
                                icon: Icon(Icons.file_upload,color:Color(0xFFc90000),size: 30),
                                onPressed: () {
                                  
                                },
                              ),
                              // title: Text(data[index]['rekening'], style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                              // subtitle: Text('Arti : ', style: TextStyle(fontWeight: FontWeight.bold),), //MENGGUNAKAN COLUMN
                            ),
                            Divider()
                          ],),
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        // backgroundColor: Color(0xFF1F3379),
        backgroundColor: Color(0xFF010F3F),
        child: Icon(Icons.edit),
        closeManually: false,
        // animatedIcon: AnimatedIcons.menu_close,
        overlayColor: Colors.black,
        onOpen: () => print('on open'),
        onClose: () => print('on close'),
        curve: Curves.easeIn,
        children: [
          SpeedDialChild(
            child: Icon(Icons.remove),
            label: 'Pengeluaran',
            backgroundColor: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pengeluaran()),
              );
            }
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            label: 'Pendapatan',
            backgroundColor: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pendapatan()),
              );
            }
          ),
        ],
      ) 
    );
  }
}