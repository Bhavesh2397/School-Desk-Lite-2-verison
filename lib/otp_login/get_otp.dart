// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class getOtp extends StatefulWidget {
  getOtp({Key? key}) : super(key: key);

  @override
  State<getOtp> createState() => _getOtpState();
}

class _getOtpState extends State<getOtp> {
  @override
  Widget build(BuildContext context) {
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Verify OTP',
                    style: TextStyle(fontSize: 20, letterSpacing: 2),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Text(
                        'OTP Sent to 86XXXXXXX83',
                        style:
                            GoogleFonts.kanit(color: Colors.grey, fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 64,
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            style: GoogleFonts.kanit(
                                color: Colors.white, fontSize: 25),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 64,
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            style: GoogleFonts.kanit(
                                color: Colors.white, fontSize: 25),
                            decoration: InputDecoration(
                              hoverColor: Colors.amber,
                              filled: true,
                              fillColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 64,
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            style: GoogleFonts.kanit(
                                color: Colors.white, fontSize: 25),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 64,
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1)
                            ],
                            style: GoogleFonts.kanit(
                                color: Colors.white, fontSize: 25),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        'Didnt Recieve OTP?',
                        style:
                            GoogleFonts.kanit(color: Colors.grey, fontSize: 18),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Resend OTP',
                            style: GoogleFonts.kanit(
                                color: Colors.amber, fontSize: 16),
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            'Verify and Login',
            style: GoogleFonts.kanit(color: Colors.white, fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            //  backgroundColor: Colors.amber,
              elevation: 0,
              padding: EdgeInsets.all(12)),
        ),
      ),
    );
  }
}
