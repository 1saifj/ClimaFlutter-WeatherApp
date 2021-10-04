import 'dart:convert' as conv;
import 'package:http/http.dart' as http;

class Networking {
  Networking(this.url);

  final Uri url;
  Future getWeatherData() async {

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {

      String data = response.body;
      return conv.jsonDecode(data);
    }else {
      print(response.statusCode);
    }
  }
}
