import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String urlSource;

  NetworkHelper({this.urlSource});

  Future getData() async {
    var uri = Uri.parse(urlSource);
    final String host = uri.host;
    final String path = uri.path;
    final Map queryParameters = uri.queryParameters;

    Uri url = Uri.https('$host', '$path', queryParameters);
    print('$url');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var _decoded = jsonDecode(data);
      return _decoded;
    } else {
      print('ERROR ERROR ... ${response.statusCode}\n\n    ${response.body}');
    }
  }
}