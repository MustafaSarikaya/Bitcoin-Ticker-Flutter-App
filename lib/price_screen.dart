import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_app/coin_data.dart';
import 'dart:io' show Platform;
import 'dart:math' as math;


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  List<List<Color>> colours = [];

  void generateColours() {
    List<Color> yellow = [Color(0xFFFDC730), Color(0xFFF37635)];
    List<Color> blue = [Color(0xFF3B93E4), Color(0xFFE66FAF)];
    List<Color> purple = [Color(0xFFFA466D), Color(0xFF435EF8)];
    colours.add(yellow);
    colours.add(blue);
    colours.add(purple);
  }


  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String item in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(
          item,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        value: item,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      dropdownColor: Colors.white,
        iconEnabledColor: Colors.black,
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getData();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(
        Text(
          currency,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        getData();
      },
      children: pickerItems,
    );
  }

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    generateColours();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cryptoList.length,
                itemBuilder: (context, n) => CryptoCard(
                  cryptoCurrency: cryptoList[n],
                  selectedCurrency: selectedCurrency,
                  colourList: colours[n %3],
                  value: isWaiting ? '?' : coinValues[cryptoList[n]],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              child: Platform.isIOS ? iOSPicker() : androidDropdown(),
            ),
          ),
        ],
      ),
    );
  }
}


class CryptoCard extends StatelessWidget {
  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
    this.colourList,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;
  final List<Color> colourList;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(35.0, 18.0, 35.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colourList ?? [Colors.yellow, Colors.orange]),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cryptoCurrency,
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedCurrency,
                            style: TextStyle(
                              color: Color(0xFFC6DFF6),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            value,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 60.0,
                      ),
                      Text(
                        'cryptocard',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFFC6DFF6),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class GradientCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(

    );
  }
}

