import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/pages/HomePage.dart';
import 'package:shopping/pages/Sign_up.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:shopping/provider/provider_auth.dart';
import 'package:shopping/components/loading.dart';
import 'package:shopping/components/data_retrive.dart';

class Login_page extends StatefulWidget {
  @override
  _Login_pageState createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  String _email;
  String _pass;

  ///===========google sign in & Texformfiled porperties=====/////
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _formkey = GlobalKey<FormState>();
  TextEditingController _emailtextcontroller = TextEditingController();
  TextEditingController _passwordtextcontroller = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedIn = false;
  DataRetrive userdata = DataRetrive();

  ///=======validate password function==========///
  String validatePassword(String value) {
    if (value.isEmpty) {
      return "The password cannot be empty";
    } else if (value.length < 6)
      return 'The password has to be atleast 6 charchter';
    else
      return null;
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

  ///==hide-password==//
  bool hidepass = true;

  final firestoreInstance = Firestore.instance;

  ///=======Handle Google Sign In function=========///

  Future<FirebaseUser> handlesignin() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;
    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .setData({
          "uid": firebaseUser.uid,
          "name": firebaseUser.displayName,
          "profilePicture": firebaseUser.photoUrl,
          "email": firebaseUser.email,
        });
        await preferences.setString("email", firebaseUser.email);
        await preferences.setString("uid", firebaseUser.uid);

        await preferences.setString("name", firebaseUser.displayName);
        await preferences.setString("profilePicture", firebaseUser.photoUrl);
      } else {
        await preferences.setString("uid", documents[0]['email']);

        await preferences.setString("uid", documents[0]['uid']);
        await preferences.setString("name", documents[0]['name']);
        await preferences.setString(
            "profilePicture", documents[0]['profilePicture']);
      }
      Fluttertoast.showToast(msg: "Login was Successful");
      setState(() {
        loading = false;
      });
    } else {}
  }

  final _key = GlobalKey<ScaffoldState>();

  ///========handle login function ======///

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

                              ///====broder_radius or edges of textformfield===///
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14),

                                ///==============Text_form_field for email===================///
                                child: TextFormField(
                                  controller: _emailtextcontroller,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(Icons.email),
                                    hintText: "Email",
                                  ),
                                  validator: validateEmail,
                                  onSaved: (String val) {
                                    _email = val;
                                  },
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
                                      border: InputBorder.none,
                                      icon: Icon(Icons.lock),
                                      hintText: "Password",
                                    ),
                                    obscureText: hidepass,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: validatePassword,
                                    onSaved: (String val) {
                                      _pass = val;
                                    },
                                  ),
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

                          ///==============Text_form_field for login===================///

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
                                      userdata.getUserData();

                                      if (_formkey.currentState.validate()) {
                                        if (!await user.signIn(
                                            _emailtextcontroller.text,
                                            _passwordtextcontroller.text))
                                          _key.currentState.showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text("Sign in failed")));
                                      }
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  )),
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Other Login Options',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),

                          ///==============Matterial Button for other_login options==================///

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              color: Colors.red,
                              elevation: 0,
                              borderRadius: BorderRadius.circular(20),
                              child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () {
                                    handlesignin().whenComplete(() {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    });
                                  },
                                  child: Text(
                                    "SignIn with Google",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 55),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "DON'T HAVE AN ACCOUNT?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUp()));
                                  },
                                  child: Text(
                                    ' SIGN UP',
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
