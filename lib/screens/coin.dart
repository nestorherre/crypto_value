import 'package:crypto_value/utils/coin_data.dart';
import 'package:crypto_value/utils/networking.dart';
import 'package:crypto_value/widgets/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CoinPage extends StatefulWidget {
  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  NetworkHelper networkHelper = NetworkHelper();
  // starts at 19 = USD
  int dropDownValue = 19;

  List<DropdownMenuItem> currencies = [];
  List<String> coinCardValues = [];

  void setUnknownCoinCardValues() {
    coinCardValues = [
      '?',
      '?',
      '?',
    ];
  }

  void populateCurrencies() {
    for (int i = 0; i < currenciesList.length; i++) {
      currencies.add(
        DropdownMenuItem(
          child: Text(currenciesList[i]),
          value: i,
        ),
      );
    }
  }

  Future<double> getCoinData({String finalCoin, String baseCoin}) async {
    dynamic coinData = await networkHelper.getCoinData(
        finalCoin: finalCoin, baseCoin: baseCoin);
    return coinData['rate'];
  }

  void updateCryptoRates() async {
    try {
      for (int i = 0; i < cryptoList.length; i++) {
        double cryptoValue = await getCoinData(
            finalCoin: cryptoList[i], baseCoin: currenciesList[dropDownValue]);
        coinCardValues[i] = cryptoValue.toStringAsFixed(0);
      }
    } catch (e) {
      Toast.show(
          'Error. Check your Internet connection or contact the admin of the app.',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setUnknownCoinCardValues();
    populateCurrencies();
    updateCryptoRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CoinCard(
                  cardText:
                      '1 ${cryptoList[0]} = ${coinCardValues[0]} ${currenciesList[dropDownValue]}',
                ),
                CoinCard(
                  cardText:
                      '1 ${cryptoList[1]} = ${coinCardValues[1]} ${currenciesList[dropDownValue]}',
                ),
                CoinCard(
                  cardText:
                      '1 ${cryptoList[2]} = ${coinCardValues[2]} ${currenciesList[dropDownValue]}',
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.lightBlue,
              child: Center(
                child: DropdownButton(
                  dropdownColor: Colors.grey[800],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
                  iconEnabledColor: Colors.white,
                  value: dropDownValue,
                  items: currencies,
                  onChanged: (value) {
                    setState(() {
                      setUnknownCoinCardValues();
                      dropDownValue = value;
                      updateCryptoRates();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
