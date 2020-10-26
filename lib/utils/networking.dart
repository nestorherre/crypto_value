import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const String apiKey = '977E5197-24AA-4CF6-B540-D6FE6138C6AA';
const String apiURL = 'https://rest.coinapi.io/v1/exchangerate/';

class NetworkHelper {
  Future getCoinData({String finalCoin, String baseCoin}) async {
    String url = apiURL + '$finalCoin/$baseCoin?apikey=$apiKey';
    var response = await http.get(url);
    return response.statusCode == 200
        ? jsonDecode(response.body)
        : response.statusCode;
  }
}
