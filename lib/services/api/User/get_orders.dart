import 'dart:convert';
import 'dart:io';


import 'package:f_app_api/services/api/constant_api.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Response> getOrders() async {
  try {
    final box = GetStorage();
    var url = Uri.http(ApiALl().url, ApiALl().readAll);
    var response =
        await http.get(url, headers: {"authorization": box.read("token")});
    if (response.statusCode == 401) {
      box.remove("token");
    }
    return response;
  } on HttpException catch (error) {
    return Response(error.message, 111);
  } on ArgumentError catch (error) {
    return Response(error.message, 111);
  } on ClientException catch (error) {
    return Response(error.message, 111);
  } on FlutterError catch (error) {
    return Response("error", 111);
  } catch (error) {
    return Response("error", 111);
  }
}
