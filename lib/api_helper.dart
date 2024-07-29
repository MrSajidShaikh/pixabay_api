import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Helper
{
  Future<Map> fetchApiData(String search)
  async {
    Uri url = Uri.parse('https://pixabay.com/api/?key=45166468-c771e21f5518e48d9c9acf6ae&q=$search');

    Response response = await http.get(url);
    if(response.statusCode == 200)
    {
      final json = response.body;
      final Map data = jsonDecode(json);
      return data;
    }
    else {
      return {};
    }
  }
}
