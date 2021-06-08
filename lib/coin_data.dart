import 'package:bitcoin_ticker_app/constants.dart';
import 'networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'DOGE',
  'BNB',
  'XRP',
  'ADA',
  'FIL',
  'DOT',
  'MATIC',
  'BUSD',
];

class CoinData {
  Future getCoinData(String currency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      NetworkHelper networkHelper = NetworkHelper(
          urlSource:
              'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$apiKey');

      var coinData = await networkHelper.getData();
      if (coinData == null){

      }
      double prices = coinData['rate'];
      cryptoPrices[crypto] = prices.toStringAsFixed(2);
    }
    return cryptoPrices;
  }
}
