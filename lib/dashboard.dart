import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oraantest/handler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Ui color = Ui();
  static Handler handler = Handler('installment/get-by-userid');
  String url = handler.getUrl();
  String amount = '';
  @override
  void initState(){

    getInstallment();
    super.initState();
  }

  getInstallment() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('userId');

    var response = await http.get(Uri.encodeFull('$url?user_id=$userId'),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });
    print(response.body);
    var decode = json.decode(response.body);
    setState(() {
      var data = decode['data'];
      amount = data['lifeTimeSavings'];
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: color.darkgreen,
        // title: Text(),
        bottom: PreferredSize(
          child: Container(
            alignment: Alignment.center,
            color: color.darkgreen,
            constraints: BoxConstraints.expand(height: 140),
            child: Column(
              children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Image.asset('images/avatar.png')),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Juhi Jaferii',style: GoogleFonts.notoSans(textStyle: Theme.of(context).textTheme.subtitle2,color: Colors.white),
                )
                )
                ],
            )
          ),
          preferredSize: Size(100, 100),
        ),
      ),
      body: Container(
        child: Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/icon2.png'),
              ],
            ),
            Text('Your patience and discipline is paying off!!',style: GoogleFonts.notoSans(textStyle: Theme.of(context).textTheme.caption,color: color.darkgreen,fontWeight: FontWeight.w400,),),
            Text('Lifetime savings',style: GoogleFonts.notoSans(textStyle: Theme.of(context).textTheme.subtitle1,color: color.darkgreen,fontWeight: FontWeight.w400,fontSize: 16) ,),
            Text('PKR $amount', style:GoogleFonts.notoSans(textStyle: Theme.of(context).textTheme.headline5,color: color.darkgreen,fontWeight: FontWeight.w400,fontSize: 24))

          ],
        ),
      ),

    );
  }
}
