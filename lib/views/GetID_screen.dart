import 'dart:convert';

import 'package:f_app_api/services/api/User/getByID.dart';
import 'package:f_app_api/views/signup_screen.dart';
import 'package:flutter/material.dart';

class GetScreenID extends StatefulWidget {
  const GetScreenID({super.key});

  @override
  State<GetScreenID> createState() => _GetScreenIDState();
}

class _GetScreenIDState extends State<GetScreenID> {
  Map order = {};
  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Get Order ID"),

      ),
      body: ListView(children: [
        TextFieldCustom(controller: idController, hint: "enter id", label: "ID", icon: Icons.insert_drive_file),
        Center(
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
                  try {
                    if (int.parse(idController.text) is int) {
                      order = json.decode((await getByID(id: idController.text)).body);
                      print(order);
                      if ((order["data"] as List).isEmpty) {
                        order = {};
                      } else {
                        order = order["data"][0];
                      }

                      setState(() {});
                    }
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("plase enter correct number")));
                  }
                },
                child: Text("Get id"))),
        Card(
          elevation: 3,
          child: Visibility(
              visible: order.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(order["id"].toString()),
                    ),
                    Text(order["title"].toString()),
                    Text(order["content"].toString()),
                    Text(order["create_at"].toString()),
                  ],
                ),
              )),
        ),
      ]),
    );
  }
}
