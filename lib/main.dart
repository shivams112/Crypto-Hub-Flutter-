import 'dart:convert';

import 'package:flutter/material.dart';
import './home_page.dart';
import 'package:http/http.dart' as http;

void main() async {
  List currencies;
  currencies = await getCurrencies();
  print(currencies);
  print(currencies.length);
  runApp(new MyApp(currencies));
}

class MyApp extends StatelessWidget {
  final List currencies;
  MyApp(this.currencies);

  @override
  Widget build(BuildContext context) {
   // Color color = new Color(0xff202020);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.pink),
      home: new HomePage(currencies),
    );
  }
}

Future<List> getCurrencies() async {
  String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/";
  http.Response response = await http.get(cryptoUrl);
  return json.decode(response.body);
}
