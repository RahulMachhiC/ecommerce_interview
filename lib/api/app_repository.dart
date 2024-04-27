import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:interview/api/api_base_helper.dart';

class AppRepository {
  ApiBaseHelper helper = ApiBaseHelper();

  Future<dynamic> fetchproducts() async {
    final response = await helper.get(
      "https://dummyjson.com/products",
    );

    return response;
  }

  Future<dynamic> fetchsingleproduct({required String productid}) async {
    final response = await helper.get(
      "https://dummyjson.com/products/$productid",
    );

    return response;
  }

  Future<dynamic> register(
      {required String username,
      required String password,
      required String email}) async {
    final response =
        await helper.post("https://hkweb.co.in/hkwebcoi/api/register", {
      "email": email,
      "password": password,
      "username": username,
    });

    return response;
  }

  Future<dynamic> login(
      {required String password, required String email}) async {
    final response =
        await helper.post("https://hkweb.co.in/hkwebcoi/api/login", {
      "email": email,
      "password": password,
    });

    return response;
  }

  Future<dynamic> addfavorite(
      {required String userid, required String productid}) async {
    final response =
        await helper.post("https://hkweb.co.in/hkwebcoi/api/add_favourite", {
      "user_id": userid,
      "product_id": productid,
    });

    return response;
  }

  Future<dynamic> removefavorite(
      {required String userid, required String productid}) async {
    final response = await helper.get(
      "https://hkweb.co.in/hkwebcoi/api/remove_favourite/$userid/$productid",
    );

    return response;
  }

  Future<dynamic> edituser(
      {required String username,
      required String password,
      required String id,
      required String email}) async {
    final response =
        await helper.post("https://hkweb.co.in/hkwebcoi/api/edit_profile", {
      "id": id,
      "email": email,
      "password": password,
      "username": username,
    });

    return response;
  }
}
