// ignore_for_file: prefer_const_constructors, unused_field, sort_child_properties_last

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:schooldesklight/main.dart';
import 'package:schooldesklight/otp_login/register_with_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import '../models/useraccounts.dart';
import '../utils/shared_preferences.dart';
import '../utils/theme.dart';
import 'SchoolDeskWebView.dart';

class LoginPage extends StatefulWidget {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('UserName');
    var fcmtoken = prefs.getString('fcmtoken');
    if (!prefs.containsKey('userData')) {
      return false;
    }
  }

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHiddenPassword = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    checkUserStatus();
    super.initState();

  }

  checkUserStatus() async {
    var isLoggedIn = await getUserContextData();
    if (isLoggedIn.isLoggedIn == true && isLoggedIn.token.isNotEmpty) {
      CircularProgressIndicator();
      getweburl();
      //Navigator.of(context).pushNamed('/UserAccountPage');

    }
  }

  void getweburl() async {
    var webtoken = "";
    var baseURL = "";
    await webLogin().then((pref) {
      setState(() {
        CircularProgressIndicator();
        webtoken = pref!;
        baseURL = BaseConfig.webURL;
        final cookieManager = WebviewCookieManager();
        cookieManager.clearCookies();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SchoolDeskWebView(
                    weburl: "$baseURL$webtoken&ReturnUrl=public/login")));
      });
    });
  }

  //await getUserContextData();

  final _otpformkey = GlobalKey<FormState>();
  final _passwordformkey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpUserNameController = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();

  loginWithPassword() async {
    CircularProgressIndicator(backgroundColor: Colors.amber,);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      CircularProgressIndicator(
        backgroundColor: Colors.amber,
      );
      var userAccount =
          await createTokan(_userNameController.text, _passwordController.text);
      var lmodel = LocalStoredModel(
          appUserHash: '',
          token: '',
          userName: '',
          fullName: '',
          profileURL: '',
          userType: '',
          appUserId: 0,
          email: '',
          isAccountActive: false,
          isLoggedIn: false,
          mobile: '',
          profileImage: '',
          remoteUId: '',
          deviceId: '',
          fcmtoken: '',
          );
      print('profileImage ----> ${userAccount.profileImage}');
      print('profileImage ----> ${userAccount.profileURL}');
      lmodel.appUserHash = userAccount.appUserHash;
      lmodel.appUserId = userAccount.appUserId;
      lmodel.isAccountActive = true;
      lmodel.profileImage = userAccount.profileImage;
      lmodel.profileURL = userAccount.profileURL;
      lmodel.remoteUId = userAccount.remoteUId;
      lmodel.userType = userAccount.userType;
      lmodel.token = userAccount.token;
      lmodel.email = userAccount.email;
      lmodel.mobile = userAccount.mobile;
      lmodel.isLoggedIn = true;
      lmodel.remoteUId = userAccount.remoteUId;
      lmodel.userName = userAccount.userName;
      lmodel.fullName = userAccount.fullName;
      lmodel.deviceId = userAccount.deviceId;

      if (userAccount.token.isNotEmpty && userAccount.appUserHash.isNotEmpty) {
        CircularProgressIndicator(backgroundColor: Colors.amber,);
        lmodel.isLoggedIn = true;

        var shareddata = await updateUserContext(lmodel);
        if (shareddata.token == userAccount.token &&
            shareddata.isLoggedIn == true) {
              CircularProgressIndicator(backgroundColor: Colors.amber,);
          hideLoader();
          getweburl();
          //await Navigator.pushNamed(context, '/UserAccountPage');
        }
      } else {
        await deleteAllUserContext();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  loginWithOTP() {}
  getOTP() {}
  bool _otpLoginStatus = false;

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    systemNavigationBarColor:
    Color.fromARGB(255, 255, 204, 0);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 255, 204, 0),
        systemNavigationBarDividerColor: Color.fromARGB(255, 255, 204, 0),
        systemNavigationBarColor: Color.fromARGB(255, 255, 204, 0),
        systemNavigationBarIconBrightness: Brightness.dark));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                      top: 25.0,
                    ),
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 50,
                            width: 30,
                          ),
                          Image.asset(
                            'assets/bee.png',
                            height: 80.0,
                            width: 120.0,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              'SCHOOL DESK',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18, letterSpacing: 5),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: AutoSizeText(
                              'Login',
                              style: TextStyle(fontSize: 20, letterSpacing: 2),
                            ),
                          ),
                        ],
                      ),

                      ///////////////////*Email*/////////////////
                      Container(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 27),
                        decoration: const BoxDecoration(),
                        child: TextFormField(
                          key: formkey,
                          controller: _userNameController,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: [AutofillHints.email],
                          cursorColor: Color.fromARGB(255, 255, 204, 0),
                          decoration: InputDecoration(
                            labelText: 'Your E-mail',
                            hintText: 'abc@gmail.com',
                            filled: true,
                            fillColor: Colors.white,
                            labelStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(27)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(27),
                                borderSide: BorderSide(color: Colors.black45)),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Requires @gmail.com"),
                            EmailValidator(errorText: "Wrong Email"),
                          ]),
                        ),
                      ),

                      ////////////////////*Password*////////////////////

                      Container(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 27),
                        decoration: const BoxDecoration(),
                        child: TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          cursorColor: Color.fromARGB(255, 255, 204, 0),
                          obscureText: isHiddenPassword,
                          decoration: InputDecoration(
                            hoverColor: Color.fromARGB(255, 255, 204, 0),
                            labelText: 'Password:',
                            hintText: '****',
                            suffixIcon: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(Icons.visibility)),
                            filled: true,
                            fillColor: Colors.white,
                            labelStyle: const TextStyle(
                                color: Colors.black45, fontSize: 15),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(27)),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(27),
                                borderSide: BorderSide(color: Colors.black45)),
                          ),
                          validator: MinLengthValidator(6,
                              errorText: "At least 6 Character"),
                        ),
                      ),

                      /////////////////////// Login Button //////////////////////////////
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () async {
                          loginWithPassword();
                          
                          // SubscribeTopic1();
                        
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 204, 0),
                                borderRadius: BorderRadius.circular(27)),
                            child: Center(
                              child: Text('Login'),
                            ),
                            height: 50,
                          ),
                        ),
                      ),
                      SizedBox(height: 0,),
                      InkWell(
                        onTap: (){},
                        child: Container(
                          
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            image: DecorationImage(image: ExactAssetImage('assets/google.png'))
                          ),
                        ),
                      ),
                      Container(
                    child: TextButton(
                      child: Text(
                        "Register Using OTP",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.only(bottom: 30.0),
                        primary: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Register_with_Otp()),
                        );
                      },
                    ),
                  ),

                      ///////////////* google and facebook button*//////////////////
                    ]),
              ),
              
              
            ),
            
          ),
        ),
      ),
      
    );
  }

//////////////////password icon view start///////////////////
  void _togglePasswordView() {
    if (isHiddenPassword == true) {
      isHiddenPassword = false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {});
  }
  //////////////////password icon view end///////////////////

  void check_if_aldready_login() async {}

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
