import 'dart:io';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:interview/api/app_exceptions.dart';

class ApiBaseHelper {
  Future<dynamic> get(
    String url,
  ) async {
    debugPrint('Api Get, url $url');
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.parse(
          url,
        ),
      );
      responseJson = _returnResponse(
        response,
      );
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException(
        message: 'No Internet connection',
      );
    }
    debugPrint(
      'api get recieved!',
    );
    return responseJson;
  }

  Future<dynamic> post(
    String url,
    dynamic body,
  ) async {
    debugPrint(
      'Api Post, url ${url}',
    );

    debugPrint(body.toString());
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse(
          url,
        ),
        body: body,
      );
      debugPrint(response.body);
      responseJson = _returnResponse(
        response,
      );
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException(
        message: 'No Internet connection',
      );
    }
    debugPrint(
      'api post. $url',
    );
    return responseJson;
  }

  Future<dynamic> put(
    String url,
    dynamic body,
  ) async {
    debugPrint('Api Put, url $url');
    dynamic responseJson;
    try {
      final response = await http.put(
        Uri.parse(
          url,
        ),
        body: body,
      );
      responseJson = _returnResponse(
        response,
      );
    } on SocketException {
      debugPrint(
        'No net',
      );
      throw FetchDataException(
        message: 'No Internet connection',
      );
    }
    debugPrint('api put.');
    debugPrint(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(
    String url,
  ) async {
    debugPrint(
      'Api delete, url $url',
    );
    dynamic apiResponse;
    try {
      final response = await http.delete(
        Uri.parse(
          url,
        ),
      );
      apiResponse = _returnResponse(
        response,
      );
    } on SocketException {
      debugPrint('No net');
      throw FetchDataException(
        message: 'No Internet connection',
      );
    }
    debugPrint(
      'api delete.',
    );
    return apiResponse;
  }
}

dynamic _returnResponse(
  http.Response response,
) {
  switch (response.statusCode) {
    case 200:
      return json.decode(
        response.body.toString(),
      );

    case 400:
      var responseJson = json.decode(
        response.body.toString(),
      );
      return responseJson;
    case 401:
    case 403:
      throw UnauthorisedException(
        response.body.toString(),
      );
    case 500:
    case 201:
      var responseJson = json.decode(
        response.body.toString(),
      );
      return responseJson;
    default:
      throw FetchDataException(
        message:
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
      );
  }
}
