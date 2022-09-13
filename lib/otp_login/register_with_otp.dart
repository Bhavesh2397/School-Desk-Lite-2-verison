import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schooldesklight/otp_login/get_otp.dart';


class Register_with_Otp extends StatelessWidget {
  const Register_with_Otp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 255, 204, 0),
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/background.png'))),
          child: ListView(
            padding: const EdgeInsets.only(
              top: 50.0,
            ),
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                    width: 30,
                  ),
                  Image.asset(
                    'assets/bee.png',
                    height: 80.0,
                    width: 120.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'SCHOOL DESK',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, letterSpacing: 5),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 35.0),
                    child: Text(
                      'OTP Login',
                      style: TextStyle(fontSize: 20, letterSpacing: 2),
                    ),
                  ),
                ],
              ),

              //////////////////  /*Email*/   ////////////////
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 27),
                decoration: const BoxDecoration(),
                child: const TextField(
                  cursorColor: Color.fromARGB(255, 255, 204, 0),
                  decoration: InputDecoration(
                    labelText: 'Number',
                    hintText: '*****',
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.black45, fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(27)),
                    ),
                  ),
                ),
              ),

              //////////////////////**OTP button*/////////////////////////////

              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 35,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 204, 0),
                    elevation: 1,
                    minimumSize: const Size(70, 55),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text(
                    'Get OTP',
                    style: TextStyle(            
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => getOtp()),
                        );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Login With',
                        style: TextStyle(color: Colors.black)),
                  ]),
                ),
              ),

              //////////////////* google and facebook button*//////////////////

              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/google.png'),
                    ),
                  ),
                ),
              ),

              ////////////////////////////////Registeration//////////////////////////////////
              TextButton(
                style: TextButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 204, 0),
                ),
                onPressed: () {
                },
                child: const Text(
                  "Dont have an account? Register",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
