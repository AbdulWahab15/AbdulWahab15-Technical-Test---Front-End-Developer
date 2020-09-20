import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard.dart';
import 'handler.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var phoneNumberController  = TextEditingController();
  var passcodeController = TextEditingController();
  bool passwordVisible=false;
  Ui color = Ui();
  static Handler handler=Handler('users/login');
  String url = handler.getUrl();

  loginRequest() async {
    var response = await http.post(Uri.encodeFull(url),
        body:
        json.encode({"userPassword": passcodeController.text, "userPhone": phoneNumberController.text}),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });
    print(response.body);
    var decode =  json.decode(response.body);

    var data = decode['data'];
    var userId = data['userId'];
    var msg = data['message'];
    if(msg=='user login success'){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('userId', userId);

      Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.arrow_back_ios,color: color.darkgreen,size: 15,), onPressed: (){}),
                  Text('Welcome back',style: GoogleFonts.notoSans(textStyle: Theme.of(context).textTheme.headline5,color: color.darkgreen,fontWeight: FontWeight.w400),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: color.purple,

                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    hintText: 'Phone number',

                    labelText: 'Phone number',
                    labelStyle: TextStyle(color: color.darkgreen),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color.purple)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide()
                    )

                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor:color.purple,
                  controller: passcodeController,
                  obscureText: passwordVisible,

                  decoration: InputDecoration(
                      hintText: 'Passcode',

                      labelText: 'Passcode',
                      labelStyle: TextStyle(color: color.darkgreen),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:color.purple)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide()
                      ),
                      suffixIcon:IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          passwordVisible ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      )


                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: (){
                    loginRequest();
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(64)),
                    child: Container(
                      color: color.skyblue,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('LOGIN',style: GoogleFonts.notoSans(textStyle: Theme.of(context).textTheme.button,color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: (){

                    },
                    child: Text('FORGOT PASSCODE ?',style: GoogleFonts.notoSans(textStyle: Theme.of(context).textTheme.button,color:color.skyblue,fontWeight: FontWeight.w500,fontSize: 14),)),
              )


            ],
          ),
        ),
      ),
    ));
  }
}
