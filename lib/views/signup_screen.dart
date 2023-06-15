import 'package:f_app_api/services/api/Auth/createUser.dart';
import 'package:f_app_api/views/Login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 194, 203, 230),
      body: ListView(
        children: [
          const LabelScreen(title: "Sign up"),
          TextFieldCustom(
            hint: "user123",
            label: "User name",
            icon: Icons.person,
            onChanged: (value) {
              print(value);
              username = value;
            },
          ),
          TextFieldCustom(
            hint: "Fahad Alazmi",
            label: "Name",
            icon: Icons.email,
            controller: nameController,
          ),
          TextFieldCustom(
            hint: "example@gmail.com",
            label: "Email",
            icon: Icons.email,
            controller: emailController,
          ),
          TextFieldCustom(
            hint: "AAaa1100229933",
            label: "password",
            icon: Icons.email,
            obscureText: true,
            isPassword: true,
            onChanged: (pass) {

              password = pass;
            },
          ),
          Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () async {
                    final Map body = {
                      "email": emailController.text,
                      "password": password,
                      "username": username,
                      "name": nameController.text
                    };
                    final response = await createUser(body: body);
                    print(response.body);
                    if (response.statusCode == 200) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    }
                  },
                  child: Text("Create"))),
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: const Text('You have  account'),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom(
      {super.key,
      required this.hint,
      required this.label,
      required this.icon,
      this.isPassword = false,
      this.controller,
      this.onChanged,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines = 1});

  final String hint;
  final String label;
  final IconData icon;
  final bool? isPassword;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool obscureText;
  final int minLines;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        enabled: true,
        minLines: minLines,
        maxLines: maxLines,
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        obscuringCharacter: "*",
        cursorColor: Colors.red,
        cursorWidth: 10,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hint,
            labelText: label,
            prefixIcon: Icon(
              icon,
              color: Colors.red,
            ),
            suffixIcon: isPassword! ? const Icon(Icons.remove_red_eye) : null,
            labelStyle: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            border: const OutlineInputBorder(),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.cyanAccent))),
      ),
    );
  }
}
