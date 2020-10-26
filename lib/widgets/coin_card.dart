import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  CoinCard({@required this.cardText});
  final String cardText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
      child: Card(
        color: Colors.lightBlue,
        elevation: 8.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            cardText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
