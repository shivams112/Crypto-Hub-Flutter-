import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List currencies;
  //bool _isLoading;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];
  final List<Color> _backColors = [
    Color(0xffbbbbbb),
    Color(0xfff4e8e8),
    Color(0xffcccccc),
    Color(0xffeeeeee),
    Color(0xffdddddd),
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   _isLoading = true;
  //   // currencies = await getCurrencies();
  // }

  // Future<List> getCurrencies() async {
  //   String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/";
  //   http.Response response = await http.get(cryptoUrl);
  //   return json.decode(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Crypto Hub'),
        backgroundColor: Color(0xff8ac6d1),
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    //var getLength = widget?.currencies?.length ?? 0;
    return new Container(
        child: new Column(
      children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            itemCount: widget.currencies.length,
            itemBuilder: (BuildContext context, int index) {
              final Map currency = widget.currencies[index];
              final MaterialColor color = _colors[index % _colors.length];
              final Color backColor = _backColors[index % _backColors.length];
             // _isLoading = false;
              return _getListItemUI(currency, color, backColor);
            },
          ),
        )
      ],
    ));
  }

  Container _getListItemUI(Map currency, MaterialColor color, Color backColor) {
    return new Container(
      child: new ListTile(
        leading: new CircleAvatar(
          backgroundColor: color,
          child: new Text(
            currency['name'][0],
            style: new TextStyle(color: Colors.black),
          ),
        ),
        title: new Text(
          currency['name'],
          style: new TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: _getSubtitleText(
            currency['price_usd'], currency['percent_change_1h']),
        isThreeLine: true,
      ),
      color: backColor,
      //margin: EdgeInsets.only(bottom: 8.0),
    );
  }

  Widget _getSubtitleText(String price, String percentageChanged) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$price\n", style: new TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour: $percentageChanged%";
    TextSpan percentChangeTextWidget;
    if (double.parse(percentageChanged) > 0) {
      percentChangeTextWidget = new TextSpan(
          text: percentageChangeText,
          style: new TextStyle(color: Colors.green));
    } else {
      percentChangeTextWidget = new TextSpan(
          text: percentageChangeText, style: new TextStyle(color: Colors.red));
    }
    return new RichText(
      text: new TextSpan(children: [priceTextWidget, percentChangeTextWidget]),
    );
  }
}
