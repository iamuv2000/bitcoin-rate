import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'services/NetworkHelper.dart';
import 'dart:math';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedCurrency = 'AUD';
  String price = '?';

  void getRate(int index) async {
    String currency = currenciesList[index];
    NetworkHelper exchangeRate = NetworkHelper('https://blockchain.info/ticker');
    var rates = await exchangeRate.getData();
    setState(() {
      selectedCurrency = currency;
      price = rates[currency]['buy'].toStringAsFixed(2);
    });
  }

  List<Widget> getDropDownItem () {
    List<Widget> dropdownItems = [];

    for(int i = 0; i<currenciesList.length;i++){
      String currency = currenciesList[i];
      var newItem  = Text(
          currency,
          style: TextStyle(color: Colors.white),
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $price $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlueAccent,
            child: CupertinoPicker(
              backgroundColor: Colors.lightBlueAccent,
              itemExtent: 32.0,
              onSelectedItemChanged: (selectedIndex){
                getRate(selectedIndex);
              },
              children: getDropDownItem(),
            ),
          ),
        ],
      ),
    );
  }
}

//DropdownButton<String> (
//value: selectedCurrency,
//items: getDropDownItem(),
//onChanged: (value){
//setState(() {
//selectedCurrency = value;
//});
//},
