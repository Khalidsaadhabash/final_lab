import 'dart:convert';

import 'package:f_app_api/services/api/Auth/login.dart';
import 'package:f_app_api/views/Home_screen.dart';
import 'package:f_app_api/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(children: [
          Container(
            height: 30,
          ),
          LabelScreen(
            title: "Log In",
          ),
          Container(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              minLines: 1,
              keyboardType: TextInputType.text,
              maxLines: 1,
              enableSuggestions: false,
              autocorrect: false,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
                labelText: 'example@gmail.com',
              ),
              onChanged: (String? val) {
                emailController.text = val!;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              // maxLength: 8,
              minLines: 1,
              // keyboardType: TextInputType.text,
              keyboardType: TextInputType.visiblePassword,
              // controller: controller.titleController,
              maxLines: 1,

              // style: UtilsImporter().uStyleUtils.loginTextFieldStyle(),
              enableSuggestions: false,
              autocorrect: false,
              textDirection: TextDirection.ltr,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(
                      () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
                labelStyle: TextStyle(fontFamily: 'Cairo'),
              ),
              onChanged: (String? val) {
                passwordController.text = val!;
              },
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.green[900];
                        }
                        return Colors.green;

                        return null; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () async {
                    final Map body = {
                      "email": emailController.text,
                      "password": passwordController.text,
                    };
                    final response = await loginUser(body: body);

                    if (response.statusCode == 200) {
                      final box = GetStorage();
                      box.write("token", json.decode(response.body)["data"]["token"]);

                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }
                  },
                  child: Text("Create"))),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: const Text(
                'You do not have an account',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

//extisin pusg
//create anthor pop
class LabelScreen extends StatelessWidget {
  const LabelScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      title,
      style: TextStyle(fontFamily: "TiltPrism", fontWeight: FontWeight.w900, fontSize: 30),
    ));
  }
}
