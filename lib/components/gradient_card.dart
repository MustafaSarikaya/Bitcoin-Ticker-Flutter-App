import 'package:flutter/material.dart';

class GradientCard extends StatelessWidget {
  GradientCard({
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
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colourList ?? [Colors.yellow, Colors.orange]),
          borderRadius: BorderRadius.circular(15.0),
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
    );
  }
}