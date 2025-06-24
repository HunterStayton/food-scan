import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'create_account_screen.dart';
import 'home_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Map userData = {};

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login'), backgroundColor: Colors.green, foregroundColor: Colors.white, centerTitle: true),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),

                    border: Border.all(color: Colors.blueGrey),
                  ),
                  child: Icon(Icons.food_bank_rounded, size: 64, color: Colors.grey),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          validator:
                              MultiValidator([
                                RequiredValidator(errorText: 'Enter email address'),
                                EmailValidator(errorText: 'Please correct email filled'),
                              ]).call,
                          decoration: InputDecoration(
                            hintText: 'Email',

                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                            ),

                            errorStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.all(
                                Radius.circular(9.0),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          validator:
                              MultiValidator([
                                RequiredValidator(
                                  errorText: 'Please enter Password',
                                ),
                                MinLengthValidator(
                                  8,

                                  errorText: 'Password must be at least 8 characters',
                                ),
                                PatternValidator(
                                  r'(?=.*?[#!@$%^&*-])',
                                  errorText: 'Psw must have at least one special character',
                                ),
                              ]).call,
                          decoration: InputDecoration(
                            hintText: 'Password',

                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.key,
                              color: Colors.grey,
                            ),

                            errorStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),

                              borderRadius: BorderRadius.all(Radius.circular(9.0)),
                            ),
                          ),
                        ),
                      ),

                      Container(margin: EdgeInsets.fromLTRB(200, 0, 0, 0), child: Text('Forget Password!')),

                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,

                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                              if (_formkey.currentState!.validate()) {
                                if (kDebugMode) {
                                  print('form submitted');
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,

                              foregroundColor: Colors.white,
                            ),
                            child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 22)),
                          ),),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccount()));
                            });
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.grey, fontSize: 16, decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
