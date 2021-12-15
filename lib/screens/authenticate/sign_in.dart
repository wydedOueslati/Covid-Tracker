import 'package:covid19_news/config/colors.dart';
import 'package:covid19_news/services/auth.dart';
import 'package:covid19_news/config/constants.dart';
import 'package:covid19_news/config/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ required this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,),


        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text("Login to your account",
                    style: TextStyle(
                      fontSize: 15,
                    color:Colors.grey[700]),)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _formKey,
                    child:Column(
                     children: <Widget>[
                       Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        "Email",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color:Colors.black87
        ),

      ),
      SizedBox(
        height: 5,
      ),
      TextFormField(
        obscureText: false,
        validator: (val) => val!.isEmpty ? 'Enter an email' : null,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0,
          horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey
            ),

          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          )
        ),
        onChanged: (val) {
                  setState(() => email = val);
                },
      ),
      SizedBox(height: 10,)
    ],
  ),

   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        "Password",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color:Colors.black87
        ),

      ),
      SizedBox(
        height: 5,
      ),
      TextFormField(
        obscureText: true,
        validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0,
          horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey
            ),

          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          )
        ),
        onChanged: (val) {
                  setState(() => password = val);
                },
      ),
      SizedBox(height: 10,)
    ],
  ),
                      
                      
                     
                    ],
                  )),
                ),
                  Padding(padding:
                  EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration:
                        BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),

                          )



                        ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                                        onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Could not sign in with those credentials';
                      });
                    }
                  }
                },
                        color: colorPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        ),
                        child: Text(
                          "Login", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,

                        ),
                        ),

                      ),
                    ),
                  ),
                 SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    new GestureDetector(
  onTap: () => widget.toggleView(),
  child:                     Text(" Sign up", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,

                    ),),
),

                  ],
                ),

                Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 250,
                  child:Image.asset('assets/images/login.png',fit: BoxFit.fill,),
                )

              ],
            ))
          ],
        ),
      ),
    );
  }

}

