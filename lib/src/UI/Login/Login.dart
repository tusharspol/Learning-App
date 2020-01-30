import 'package:flutter/material.dart';
import 'package:training_app/src/UI/Common/Stylings.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            child: _loginForm(),
          ),
        ),
      ),
    );
  }

  _loginForm() {
    return Container(
      padding: EdgeInsets.only(left: 35, right: 35.0, top: 30.0, bottom: 15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Login",
              style: Style.text32SemiBold,
            ),
            Container(
              color: Style.blackTextColor,
              height: 3.0,
              width: 40.0,
              margin: EdgeInsets.only(top: 15.0, left: 4.0),
            ),
            SizedBox(
              height: 50.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'Email',
              ),
              autovalidate: true,
              autocorrect: false,
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
              obscureText: true,
              autovalidate: true,
              autocorrect: false,
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () => {},
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot password?",
                  style: Style.text12Regular,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: RaisedButton(
                onPressed: () {},
                color: Style.primaryColor,
                splashColor: Style.primaryLightColor,
                shape: Style.roundedButtonShape,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  child: Text(
                    "LOGIN",
                    style: Style.buttonTextStyle,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 50.0,
            ),
            Align(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        style: Style.text12Regular,
                      ),
                      Text(
                        " SIGN UP",
                        style: Style.signupLinkTextStyle,
                      ),
                    ],
                  ),
                ),
                alignment: Alignment.bottomCenter,
              ),
          ],
        ),
      ),
    );
  }
}
