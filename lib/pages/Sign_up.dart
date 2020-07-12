import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/pages/HomePage.dart';
import 'package:shopping/components/users.dart';
import 'package:provider/provider.dart';
import 'package:shopping/pages/login.dart';
import 'package:shopping/provider/provider_auth.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:shopping/components/loading.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String gender = 'male';
  final _formkey = GlobalKey<FormState>();

  ///===========signUp in & Texformfiled porperties=====/////

  TextEditingController _emailtextcontroller = TextEditingController();
  TextEditingController _nameltextcontroller = TextEditingController();
  TextEditingController _passwordtextcontroller = TextEditingController();

  ///====gender funtion for radion button=====///
  String groupValue = "male";
  bool hidepass = true;
  void valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
        gender = 'male';
      } else if (e == "female") {
        groupValue = e;
        gender = 'female';
      }
    });
  }

  ///==========validate email function==========////

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                ///===background_image====///

                Image.asset(
                  'images/back.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),

                ///====background_color_Opacity===///

                Container(
                  color: Colors.black.withOpacity(0.4),
                  height: double.infinity,
                  width: double.infinity,
                ),

                ///====list_View for the Login TextFormField===///

                Padding(
                  padding: const EdgeInsets.only(top: 220),
                  child: Center(
                    child: Form(
                      key: _formkey,
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              color: Colors.white.withOpacity(0.8),
                              elevation: 0,
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14),

                                ///==============Text_form_field for name===================///

                                child: TextFormField(
                                  controller: _nameltextcontroller,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.person),
                                      hintText: "Name",
                                      border: InputBorder.none),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "The name field cannot be empty";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                          ),

                          ///=========Radio button for the gender========//
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.8),
                              elevation: 0,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: ListTile(
                                    title: Text("Male"),
                                    trailing: Radio(
                                        value: "male",
                                        groupValue: groupValue,
                                        onChanged: (e) => valueChanged(e)),
                                  )),
                                  Expanded(
                                      child: ListTile(
                                    title: Text("Female"),
                                    trailing: Radio(
                                        value: "female",
                                        groupValue: groupValue,
                                        onChanged: (e) => valueChanged(e)),
                                  ))
                                ],
                              ),
                            ),
                          ),

                          ///==============Text_form_field for email===================///

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              color: Colors.white.withOpacity(0.8),
                              elevation: 0,
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: TextFormField(
                                  controller: _emailtextcontroller,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.email),
                                      hintText: "Email",
                                      border: InputBorder.none),
                                  validator: validateEmail,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ),
                          ),

                          ///==============Text_form_field for password===================///

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              color: Colors.white.withOpacity(0.8),
                              elevation: 0,
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: ListTile(
                                  title: TextFormField(
                                    controller: _passwordtextcontroller,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.lock),
                                        hintText: "Password",
                                        border: InputBorder.none),
                                    obscureText: hidepass,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "The password field cannot be empty";
                                      } else if (value.length < 6) {
                                        return "the password has to be at least 6 characters long";
                                      }
                                      return null;
                                    },
                                  ),

                                  ///=====hide password=====///
                                  trailing: IconButton(
                                      icon: Icon(Icons.remove_red_eye),
                                      onPressed: () {
                                        setState(() {
                                          hidepass = false;
                                        });
                                      }),
                                ),
                              ),
                            ),
                          ),

                          ///TODO: sigup issue not going to home page

                          ///============register button===========///
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              color: Colors.blue,
                              elevation: 0,
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: MaterialButton(
                                    minWidth: MediaQuery.of(context).size.width,
                                    onPressed: () async {
                                      if (_formkey.currentState.validate()) {
                                        if (!await user.signUp(
                                            _nameltextcontroller.text,
                                            _emailtextcontroller.text,
                                            _passwordtextcontroller.text)) {
                                          _key.currentState.showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text("Sign up failed")));
                                          return;
                                        }

                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()));
                                      }
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 55),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "ALREADY HAVE AN ACCOUNT?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Login_page()));
                                  },
                                  child: Text(
                                    ' LOGIN',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                ///===========icon for loading when async method is running====////
              ],
            ),
    );
  }
}
